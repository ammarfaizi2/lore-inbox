Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270986AbTHGUwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270988AbTHGUwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:52:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12780 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270986AbTHGUw3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:52:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] Readahead issues and AIO read speedup
Date: Thu, 7 Aug 2003 13:41:50 -0700
User-Agent: KMail/1.4.1
Cc: suparna@in.ibm.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
References: <20030807100120.GA5170@in.ibm.com> <200308071021.39816.pbadari@us.ibm.com> <20030807103930.69e497a7.akpm@osdl.org>
In-Reply-To: <20030807103930.69e497a7.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308071341.50834.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 August 2003 10:39 am, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > We should do readahead of actual pages required by the current
> > read would be correct solution. (like Suparna suggested).
>
> I repeat: what will be the effect of this if all those pages are already in
> pagecache?

Hmm !! Do you think just peeking at pagecache and bailing out if
nothing needed to be done, is too expensive ? Anyway, slow read
code has to do this later. Doing it in readahead one more time causes
significant perf. hit ? And also, do you think this is the most common
case ?


Thanks,
Badari
