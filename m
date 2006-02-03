Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWBCIqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWBCIqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWBCIqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:46:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:17624 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750831AbWBCIqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:46:16 -0500
Date: Fri, 3 Feb 2006 09:45:36 +0100 (CET)
From: Armin Schindler <armin@melware.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Adrian Bunk <bunk@stusta.de>, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org,
       kkeil@suse.de
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
In-Reply-To: <1138924621.3788.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602030941580.13271@phoenix.one.melware.de>
References: <20060131213306.GG3986@stusta.de> <1138743844.3968.14.camel@localhost.localdomain>
 <20060202214059.GB14097@stusta.de> <1138924621.3788.2.camel@localhost.localdomain>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Marcel Holtmann wrote:
> Hi Adrian,
> 
> > > > This patch contains the following cleanups:
> > > > - move the help text to the right option
> > > > - replace some #ifdef's in capi.c with dummy functions in capifs.h
> > > > - use CONFIG_ISDN_CAPI_CAPIFS_BOOL in one place in capi.c
> > > 
> > > I actually still like to see capifs removed completely. It is not really
> > > needed if you gonna use udev. The only thing that it is doing, is to set
> > > the correct permissions and make sure that the device nodes are created.
> > > And with a 2.6 kernel this can be all done by udev.
> > 
> > udev is not mandatory.
> > 
> > Static /dev is still 100% supported and working fine.
> 
> and if you have static /dev then you can use mknod and chown by
> yourself. If you use CAPI on any newer distribution with the latest 2.6
> kernel you will have udev anyway and so no static /dev at all.

Sorry for my ignorance, but I think capifs was introduced to have own 
dynamic 'files' like pts and not to have the restrictions of character 
devices and the needed major/minor numbers.

So changing this to character device nodes may break applications
out there.

Armin

