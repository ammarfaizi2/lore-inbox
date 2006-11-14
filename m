Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966425AbWKNWsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966425AbWKNWsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966427AbWKNWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:48:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966425AbWKNWsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:48:07 -0500
Date: Tue, 14 Nov 2006 14:45:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA ICH5 not detected at boot, mm-kernels
Message-Id: <20061114144524.b91a4e55.akpm@osdl.org>
In-Reply-To: <200611142252.42623.cova@ferrara.linux.it>
References: <200611051536.35333.cova@ferrara.linux.it>
	<200611131017.51676.cova@ferrara.linux.it>
	<20061113132904.52e6fde7.akpm@osdl.org>
	<200611142252.42623.cova@ferrara.linux.it>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 22:52:42 +0100
Fabio Coatti <cova@ferrara.linux.it> wrote:

> Alle 22:29, luned__ 13 novembre 2006, Andrew Morton ha scritto:
> 
> >
> > In an earlier email, Tejun said:
> > > >> Nov  5 13:26:37 kefk ata: 0x170 IDE port busy
> > > >> Nov  5 13:26:37 kefk ata: conflict with ide1
> > > >
> > > > hm.  What does that mean?
> > >
> > > It means that IDE layer claimed the port.  It can be overridden by
> > > combined_mode kernel parameter.
> >
> > Did you try that?
> 
> Uh, well, to be honest, no..or better: not yet :)
> 
> anyway, applying this patch: http://lkml.org/lkml/2006/11/13/150
> tghe problem disappeared and 2.6.19-rc5-mm1 booted just fine, seeing all 
> ata_piix devices.

Great, thanks.

I have that fix in rc5-mm2, as
pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks-ide-fix.patch
- a fix against Greg's
gregkh-pci-pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks.patch

There is no problem which cannot be solved with a sufficiently long filename.
