Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTDTU7G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 16:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbTDTU7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 16:59:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17674 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263695AbTDTU7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 16:59:05 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [CFT] more kdev_t-ectomy
Date: 20 Apr 2003 14:10:36 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7v2cc$ll$1@cesium.transmeta.com>
References: <20030420133143.GF10374@parcelfarce.linux.theplanet.co.uk> <20030420160034.GA20123@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030420160034.GA20123@win.tue.nl>
By author:    Andries Brouwer <aebr@win.tue.nl>
In newsgroup: linux.dev.kernel
> 
> Of course it may be possible to avoid kernel-internal numbers altogether.
> Sometimes that is an improvement, sometimes not. Pointers are more
> complicated than numbers - they point at something that must be allocated
> and freed and reference counted. A number is like a pointer without the
> reference counting.
> 

I guess the question is: is there any point to have three forms --
with necessary conversions between them -- or is it simpler to have
two forms and just use the more awkward dev_t form everywhere?  The
only use for dev_t's in the kernel should be getting them from or
shipping them off to userspace at some point, so it might be just as
easily to do the conversion directly -- macroized, of course.

We do need a dev32_t for NFSv2 et al, though.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
