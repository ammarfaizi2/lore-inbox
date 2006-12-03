Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425009AbWLCHFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425009AbWLCHFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 02:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425011AbWLCHFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 02:05:54 -0500
Received: from pat.uio.no ([129.240.10.15]:10978 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1425009AbWLCHFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 02:05:53 -0500
Subject: Re: Mounting NFS root FS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Willy Tarreau <w@1wt.eu>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       William Estrada <MrUmunhum@popdial.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061203060208.GA900@1wt.eu>
References: <4571CE06.4040800@popdial.com>
	 <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr>
	 <20061202211522.GB24090@1wt.eu>
	 <Pine.LNX.4.61.0612022253280.25553@yvahk01.tjqt.qr>
	 <20061202225528.GA27342@1wt.eu>
	 <1165113438.5698.5.camel@lade.trondhjem.org>  <20061203060208.GA900@1wt.eu>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 02:05:10 -0500
Message-Id: <1165129510.5745.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.316, required 12,
	autolearn=disabled, AWL 1.55, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-03 at 07:02 +0100, Willy Tarreau wrote:

> That's a valid point, but in fact, building with NFS client and serial
> port support in the kernel on some archs is as common as building with
> IDE driver and VGA console in the kernel on x86. With some architectures
> used in light networked workstations, it's very common to boot from the
> network (sparc & parisc come to mind, sorry to those I forgot), hence
> this common practise.

I have no influence over the distributions' choice of kernel compiler
options. The fact is, though, that few of them support nfsroot out of
the box. AFAICS FC-6 is one of those that appears not to.

> > As for the initramfs support, hpa has assured me that his klibc
> > distribution already has a full solution for NFS mounting on current
> > kernels.
> 
> That's again where we see the limits of this ever-developping 2.6.
> I'm not saying that doing this from initramfs+tools is a bad solution,
> since it solves lots of problems, it's just that it is *much* different
> from what was previously done.
> 
> People who have installed a distro on their machines will not be
> able to upgrade their kernel past a certain point by hand. Upgrading
> distro packages in such environments is generally not always an
> option (particularly boot packages such as boot loader and kernel),
> because the boot server is not necessarily running on the same
> OS/distro, and sometimes the kernel needs different build options.

Most people that run nfsroot systems do so because that makes
provisioning of new machines easy: if you only have one system image,
then upgrading it is less of a challenge.

> Then the remaining solution to get stability and security fixes
> is often to [cross-]compile a more recent kernel, and to put it
> on the boot server. Fortunately Adrian maintains 2.6.16 :-/

No comment.

Trond

