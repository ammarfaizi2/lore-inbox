Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbTEGWmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTEGWmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:42:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61956 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264138AbTEGWmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:42:52 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Date: 7 May 2003 15:55:13 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9c2sh$ojj$1@cesium.transmeta.com>
References: <20030507084920.GA823@suse.de> <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com> <20030507164613.GN823@suse.de> <b9bupr$jkm$2@tangens.hometree.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <b9bupr$jkm$2@tangens.hometree.net>
By author:    "Henning P. Schmiedehausen" <hps@intermeta.de>
In newsgroup: linux.dev.kernel
>
> Jens Axboe <axboe@suse.de> writes:
> 
> >I dunno what the purpose of that would be exactly, I guess to cater to
> >some hardware odditites?
> 
> Wild guess: You can use larger transfer sizes with the 48 bit
> interface, even when adressing the lower 28 bit space?
> 
> This might be a win for applications that stream large contigous
> blocks from/to a HD (Video, Audio...)
> 

Right, Jens basically does something like:

use_48_bits := (address+length > 2^28) || (length >= 2^16)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
