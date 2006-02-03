Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWBCIwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWBCIwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBCIwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:52:20 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:38851 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751027AbWBCIwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:52:19 -0500
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Armin Schindler <armin@melware.de>
Cc: Adrian Bunk <bunk@stusta.de>, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org,
       kkeil@suse.de
In-Reply-To: <Pine.LNX.4.61.0602030941580.13271@phoenix.one.melware.de>
References: <20060131213306.GG3986@stusta.de>
	 <1138743844.3968.14.camel@localhost.localdomain>
	 <20060202214059.GB14097@stusta.de>
	 <1138924621.3788.2.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602030941580.13271@phoenix.one.melware.de>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 09:53:48 +0100
Message-Id: <1138956828.3731.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

> > > > > This patch contains the following cleanups:
> > > > > - move the help text to the right option
> > > > > - replace some #ifdef's in capi.c with dummy functions in capifs.h
> > > > > - use CONFIG_ISDN_CAPI_CAPIFS_BOOL in one place in capi.c
> > > > 
> > > > I actually still like to see capifs removed completely. It is not really
> > > > needed if you gonna use udev. The only thing that it is doing, is to set
> > > > the correct permissions and make sure that the device nodes are created.
> > > > And with a 2.6 kernel this can be all done by udev.
> > > 
> > > udev is not mandatory.
> > > 
> > > Static /dev is still 100% supported and working fine.
> > 
> > and if you have static /dev then you can use mknod and chown by
> > yourself. If you use CAPI on any newer distribution with the latest 2.6
> > kernel you will have udev anyway and so no static /dev at all.
> 
> Sorry for my ignorance, but I think capifs was introduced to have own 
> dynamic 'files' like pts and not to have the restrictions of character 
> devices and the needed major/minor numbers.

I am under the impression that it was introduced to change the ownership
of the device node the current process. Nothing more, nothing less.
Please correct me if I am wrong here.
 
> So changing this to character device nodes may break applications
> out there.

Actually I stopped compiling in and using capifs over a year ago and I
never had any problems with it. However you must ensure that the device
has been created by udev, nut nowadays this is no problem.

Regards

Marcel


