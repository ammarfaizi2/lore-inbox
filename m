Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTJNUpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTJNUpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:45:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262051AbTJNUpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:45:12 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
Date: 14 Oct 2003 13:44:45 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bmhn7t$odm$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0310142131090.3044-100000@raven.themaw.net> <3F8C1BB6.9010202@sun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F8C1BB6.9010202@sun.com>
By author:    Mike Waychison <Michael.Waychison@Sun.COM>
In newsgroup: linux.dev.kernel
> 
> Here is the quick fix for this in RH 2.1AS kernels:
> 
> http://www.kernelnewbies.org/kernels/rh21as/SOURCES/linux-2.4.9-moreunnamed.patch
> 
> It makes unnamed block devices use majors 12, 14, 38, 39, as well as 0. 
> 
> I don't know if anyone is working out a better scheme for 
> get_unnamed_dev in 2.6 yet.  It does need to be done though.  A simple 
> patch for 2.6 would maybe see the unnamed_dev_in_use bitmap grow to 
> PAGE_SIZE, automatically allowing for 32768 unnamed devices.
> 

dev_t enlargement, which solves this without a bunch of auxilliary
majors, should be in 2.6.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
