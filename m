Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTDUGT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 02:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTDUGT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 02:19:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:269 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263777AbTDUGT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 02:19:57 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new system call mknod64
Date: 20 Apr 2003 23:31:18 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8037m$2al$1@cesium.transmeta.com>
References: <UTC200304202212.h3KMCIW15403.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200304202212.h3KMCIW15403.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
>
> > the _right_ interface is keeping the <major, minor> tuple explicit
> 
> Good! I debated with myself and changed three times between
> 
> 	mknod64(path, mode, major, minor);
> 
> and
> 
> 	mknod64(path, mode, devhi, devlo);
> 
> 
> This becomes the fourth time.
> 
> Andries
> 
> [My choice is still unsigned int major, minor.
> Do you prefer __u32?]
> 

Yes, if we are splitting it we definitely should make it __u32
(uint32_t), especially to be nice to the 64/32 platforms.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
