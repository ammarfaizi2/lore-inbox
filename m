Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbUKHTe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUKHTe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUKHTcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:32:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11958 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261217AbUKHTbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:31:19 -0500
Subject: Re: [PATCH] Oops in aio_free_ring on 2.6.9
From: "Darrick J. Wong" <djwong@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-aio@kvack.org, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0411061938150.2223@ppc970.osdl.org>
References: <1099683260.12365.348.camel@bluebox>
	 <Pine.LNX.4.58.0411061938150.2223@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1099942211.12365.372.camel@bluebox>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 08 Nov 2004 11:30:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-06 at 19:43, Linus Torvalds wrote:

> I don't disagree with the bug, but I disagree with the fix. 
> 
> In my opinion, the problem is that "info->nr_pages" is _wrong_. It's wrong 
> because it has been initialized to a bogus value. 
> 
> I'd much prefer this alternate appended patch. Can you verify that it also 
> fixes the problem (we can drop the bogus info->nr_pages initialization, 

You're right, that is a better fix.  The aio code is not my current area
of expertise, as I've demonstrated. :)

Your patch also fixes the problem.

Thanks,

--Darrick

