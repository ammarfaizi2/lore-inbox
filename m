Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269530AbUIZNKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbUIZNKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 09:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUIZNKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 09:10:14 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:18371 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269530AbUIZNKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 09:10:07 -0400
Subject: Re: [RFC] put symbolic links between drivers and modules in
	the	sysfs tree
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: viro@parcelfarce.linux.theplanet.co.uk, greg@kroah.com,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <E1CBWOq-0007t6-00@gondolin.me.apana.org.au>
References: <E1CBWOq-0007t6-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Sep 2004 09:09:03 -0400
Message-Id: <1096204149.10924.2.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 06:37, Herbert Xu wrote:
> James Bottomley <James.Bottomley@steeleye.com> wrote:
> >
> >> So what will your userland code do when you run it on a system with
> >> non-modular kernel currently running?
> > 
> > Not put a module in the initial ramdisk, since it would be unnecessary. 
> > The only information the patch seeks to add is the linkage between
> > driver and module.  So you can work back from sysfs to know which
> > devices have which modules
> 
> You're assuming that the kernel before/after the reboot have the same
> configuration.  This is false in general.

No I'm not.  For an initrd/initramfs the only assumption would be that
the boot device's driver is compiled in or modular.  If this isn't true,
the system won't boot anyway.

James


