Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUA1Kfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 05:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUA1Kfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 05:35:33 -0500
Received: from node-423a570c.mwc.onnet.us.uu.net ([66.58.87.12]:15364 "EHLO
	vfemail.net") by vger.kernel.org with ESMTP id S265898AbUA1Kfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 05:35:32 -0500
From: Neil Macvicar <blackmogu@vfemail.net>
To: chakkerz@optusnet.com.au
Subject: Re: Total kernel freeze under 2.6.1
Date: Wed, 28 Jan 2004 10:35:16 +0000
User-Agent: KMail/1.6.50
References: <200401261258.39232.blackmogu@vfemail.net> <200401271232.17399.chakkerz@optusnet.com.au>
In-Reply-To: <200401271232.17399.chakkerz@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401281035.16726.blackmogu@vfemail.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 January 2004 01:32, Christian Unger wrote:
> Forewarning ... i ain't "qualified" ... heck i couldn't get my gfx card to
> work on 2.6 until yesterday (and i still don't know why that was).
>
> ANYWAY
>
> i got the same symptoms, and the reason it was doing it on my system was
> that in the config i was using in several places it referenced the wrong
> chipset. via instead of nforce2 type thing.
>
> From memory it did this all over the place with regards to sound, hdd and
> memory.
> Check
> Device Drivers - ATA/ATAPI/MFM/RLL
> Character Devices - AGP Support
> 		  - i2c Support

Thanks alot ! The offending part was in the ALSA driver. It had selected Sound 
-> ALSA -> PCI -> Intel 18x0/MX440, SiS 7012; Ali 5455 ; NForce Audio; 
AMD768/8111 by default, which I missed when I built the kernel.

Even so, this ought not to hang the kernel ! I'm surprised there wasn't more 
interest in this from developers.. hangs are serious issues.

--Neil.
