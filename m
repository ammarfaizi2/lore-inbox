Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbUJ1Uwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUJ1Uwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUJ1Uwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:52:42 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:40868 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262898AbUJ1U1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:27:47 -0400
Subject: Re: BUG REPORT: User/Kernel Pointer bug in sys_poll
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Sorav Bansal <sbansal@stanford.edu>, tacetan@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041028024839.6a1e1064.akpm@osdl.org>
References: <20041028052218.52478.qmail@web50207.mail.yahoo.com>
	 <Pine.GSO.4.44.0410272246240.7124-100000@elaine9.Stanford.EDU>
	 <20041028024839.6a1e1064.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098991488.9557.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Oct 2004 20:24:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-28 at 10:48, Andrew Morton wrote:
> is safe.  We know that the address is in the 0x00000000-0xbfffffff range by
> the time we call __put_user().  And if the page at *addr it not writeable
> the kernel will take a fault.
> 
> So I see no hole.  But I wouldn't have coded it that way...

On x86 maybe. I think he's right in the sense that we may have a non x86
platform that this is not safe on.

