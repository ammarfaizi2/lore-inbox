Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVCDKYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVCDKYC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVCDKYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:24:01 -0500
Received: from mail.dif.dk ([193.138.115.101]:36269 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262711AbVCDKXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:23:44 -0500
Date: Fri, 4 Mar 2005 11:23:38 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][10/10] verify_area cleanup : deprecate
In-Reply-To: <52is48m39x.fsf@topspin.com>
Message-ID: <Pine.LNX.4.62.0503041121020.2794@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.62.0503040342510.2801@dragon.hygekrogen.localhost>
 <52is48m39x.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Roland Dreier wrote:

>     Jesper> Eventually when this has been deprecated for a while I'll
>     Jesper> send patches to completely remove the function (thoughts
>     Jesper> on how long it should be deprecated first are welcome).
> 
> I don't have an opinion on how long to wait before removing the
> function, but this patch should probably add an entry to
> Documentation/feature-removal.txt.
> 
Something like this should do I assume. I'll add that to the deprecation 
patch in the future.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-orig/Documentation/feature-removal-schedule.txt	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11/Documentation/feature-removal-schedule.txt	2005-03-04 11:19:48.000000000 +0100
@@ -15,3 +15,9 @@
 	against the LSB, and can be replaced by using udev.
 Who:	Greg Kroah-Hartman <greg@kroah.com>
 
+What:	verify_area
+When:	May 2005
+Files:	include/asm-*/uaccess.h
+Why:	Obsolete, replaced by (and simply a wrapper for) access_ok.
+Who:	Jesper Juhl <juhl-lkml@dif.dk>
+



