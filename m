Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTH1UHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTH1UHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:07:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43538 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264219AbTH1UHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:07:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Initramfs
Date: 28 Aug 2003 13:07:03 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bilnd7$jfa$1@cesium.transmeta.com>
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com> <3F44D504.7060909@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F44D504.7060909@pobox.com>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
>
> Bryan O'Sullivan wrote:
> > No.  initramfs is stuck in limbo at the moment, and early userspace is
> > unlikely to see any real work until 2.7.  Feel free to ask questions,
> > but don't expect them to result in anything actually happening.
> > 
> > If you want to do real work in this area, the klibc mailing list is the
> > place to go: http://www.zytor.com/mailman/listinfo/klibc
> 
> Correct, though there is one thing I am thinking about adding to 2.6:
> 
> Support replacing "initrd=" with "initramfs=", so that bootloaders can 
> pass a cpio image into the standard initrd memory space.
> 

Note that the initrd= option is actually a boot loader option, not a
kernel option, so the name of the option shouldn't change.

But yes, an initramfs image loaded into initrd space should be
unpacked *on top of* what's already compiled into the kernel.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
