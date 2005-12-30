Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVL3KMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVL3KMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 05:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVL3KMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 05:12:23 -0500
Received: from xizor.is.scarlet.be ([193.74.71.21]:30433 "EHLO
	xizor.is.scarlet.be") by vger.kernel.org with ESMTP
	id S1751214AbVL3KMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 05:12:22 -0500
Message-ID: <43B5089E.5090307@kefren.be>
Date: Fri, 30 Dec 2005 11:14:54 +0100
From: Ochal Christophe <ochal@kefren.be>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible bug in amd64-agp (agpgart module)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for the intrusion, but i think i've stumbled across a bug in the 
linux kernel.
On an Asus KV8-S XE motherboard, the agpgart module is unable to 
properly determine the AGP aperture size, regardless of bios options 
(AGP 8x mode & AGP 4x mode), this *might* also be related to possible 
hangs in X11 when using DRI.

Bug was seen on the following config:

Asus K8V-S XE motherboard, 512MB ram with AMD Sempron 3200 (Athlon64 core)
Witnessed with an ATI Radeon 9700 Pro card and with an Asus Radeon 9200 SE.

I'll try & test this config with some more gfx cards to see if the gfx 
card has any influence on the detection, but i'm not sure i have any 
nVidia cards available.

This phenomenon has been found in atleast the following kernel versions:

linux 2.6.12-r9
linux 2.6.14-r4
linux 2.6.14-r5
linux 2.6.14-r7

The reported aperture size is always 32M, more details can be provided, 
just ask what you need to know.

With kind regards,
Ochal Christophe
