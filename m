Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTECWWX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 18:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTECWWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 18:22:23 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:3029 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S263452AbTECWWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 18:22:22 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.4.21-rc-ac3 [drm:i830_wait_ring] *ERROR*
Date: Sun, 4 May 2003 00:34:46 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305040034.46878.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
	I've got the following error from the i830 drm modules. I attach the 
relevant lines, including when X/drm was started. The X server (4.3) was 
killed after the kernel gave the errors. 

It happened when I changed from X to a console via Ctrl-Alt-F8. I checked 
the sources:

if(time_before(end, jiffies))
                    ^^^^^^^
	DRM_ERROR("space: %d wanted %d\n", ring->space, n);
	DRM_ERROR("lockup\n");

Just in case, I had running my own program 
(http://mnm.uib.es/~gallir/cpudyn/) to change the frequency of the cpu 
dinamically according to the load. 

I tried to repeat it with _and_ without that daemon running (i.e. at 
constantfrequency) without success yet.


Regards,

PS: the laptop is a Dell X200, AGP is integrated in the kernel,

-----------------
memory : d63256e0
memory : d6325720
memory : d6325760
memory : d63257a0
[drm] AGP 0.99 on Intel i810 @ 0xe8000000 128MB
[drm] Initialized i830 1.3.2 20021108 on minor 0
mtrr: base(0xe8000000) is not aligned on a size(0x180000) boundary
memory : d6325820
memory : d6325860
memory : d63258a0
memory : d63258e0
memory : d6325920
PCI: Found IRQ 10 for device 00:02.0
PCI: Sharing IRQ 10 with 00:1d.0
PCI: Sharing IRQ 10 with 02:03.0
[drm:i830_wait_ring] *ERROR* space: 131048 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 131040 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 131032 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 131024 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 131016 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 131008 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 131000 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 130992 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 130984 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 130976 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 130968 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup
[drm:i830_wait_ring] *ERROR* space: 130960 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup

-- 
  ricardo galli       GPG id C8114D34
