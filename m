Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVC1Ll1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVC1Ll1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVC1Ll1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:41:27 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:16904 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261564AbVC1LlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:41:15 -0500
Date: Mon, 28 Mar 2005 13:37:31 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: David Dyck <david.dyck@fluke.com>, Adrian Bunk <bunk@stusta.de>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: upgrading modutils may have fixed: unresolved symbols still in 2.4.30-rc2 (usbserial needs symbol tty_ldisc_ref and tty_ldisc_deref which are EXPORT_SYMBOL_GPL)
Message-ID: <20050328113731.GA2131@pcw.home.local>
References: <20050328042001.GR30052@alpha.home.local> <6507.1112007659@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6507.1112007659@ocs3.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:00:59PM +1000, Keith Owens wrote:
> On Mon, 28 Mar 2005 06:20:01 +0200, 
> Willy Tarreau <willy@w.ods.org> wrote:
> >I believe it's because of genksyms during the build process, I had the
> >exact same problem a few weeks ago on a machine with old modutils. So
> >you should have cleaned everything and rebuilt from scratch after
> >installing your new modutils. BTW, the required modutils in
> >Documentation/Changes is still marked as 2.4.10, I hope it is still
> >enough.
> 
> You need modutils >= 2.4.14 to use the combination of
> CONFIG_MODVERSIONS with EXPORT_SYMBOL_GPL() on 2.4 kernels.

Thanks for the precision Keith.

So the following seems appropriate ?

--- ./Documentation/Changes.old	Sat Mar 26 07:42:46 2005
+++ ./Documentation/Changes	Mon Mar 28 13:35:06 2005
@@ -52,7 +52,7 @@
 o  Gnu make               3.77                    # make --version
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  modutils               2.4.10                   # insmod -V
+o  modutils               2.4.14                   # insmod -V
 o  e2fsprogs              1.25                    # tune2fs
 o  jfsutils               1.0.12                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs

Regards,
Willy

