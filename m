Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVAJMin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVAJMin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 07:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVAJMin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 07:38:43 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:32705 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262132AbVAJMim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 07:38:42 -0500
Date: Mon, 10 Jan 2005 18:08:26 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: kprobes breaks BUG() handling
Message-ID: <20050110123826.GA10736@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20050110111937.GN14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110111937.GN14239@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:19:37PM +1100, Anton Blanchard wrote:
> 
> Hi,
> 
> I was running some tests and noticed BUG() handling wasnt working as
> expected. The kprobes code has some code to check for breakpoint
> removal races and only checks for one opcode. It turns out there are
> many forms of the breakpoint instruction, comparing against one is not
> good enough.

Ah yes! I see that BUG() uses twi. I will try and send out a patch for
this soon.

Thanks,
Ananth
