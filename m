Return-Path: <linux-kernel-owner+w=401wt.eu-S964960AbWLMNVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWLMNVW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWLMNVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:21:22 -0500
Received: from krak.alatek.krakow.pl ([217.96.2.229]:5940 "EHLO
	krak.alatek.krakow.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964960AbWLMNVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:21:21 -0500
X-Greylist: delayed 1307 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 08:21:21 EST
Message-ID: <457FF939.6080504@agmk.net>
Date: Wed, 13 Dec 2006 13:59:37 +0100
From: =?UTF-8?B?UGF3ZcWCIFNpa29yYQ==?= <pluto@agmk.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos napisał(a):
>   MODPOST 618 modules
> WARNING: "__ucmpdi2" [drivers/media/video/v4l2-common.ko] undefined!
> 
> This 32-bit ppc architecture, using gcc version 4.1.2 20061115 
> (prerelease) (Debian 4.1.1-21). .config below if important.
> 
> __ucmpdi2 seems to be 64-bit comparision. gcc seems to use it for switch 
> statements on 64-bit values.
> 
> drivers/media/video/v4l2-common.c::v4l2_norm_to_name seems to be one 
> such switch statement - type of id is v4l2_std_id which is 64-bit.
> 
> Should ppc have __ucmpdi2 defined in arch-specific lib? Some other 
> architectures seem to implement it (arm, arm26, frv, h8300).

maybe it's new gcc bug.

[ already fixed ]
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21237
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=25724

