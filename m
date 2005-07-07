Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVGGMst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVGGMst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVGGMqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:46:43 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:1676 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261385AbVGGMqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:46:21 -0400
Message-ID: <42CD2428.4090406@m1k.net>
Date: Thu, 07 Jul 2005 08:46:32 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm1
References: <20050707040037.04366e4e.akpm@osdl.org>
In-Reply-To: <20050707040037.04366e4e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>- I seem to have quite a bit of material here which is appropriate to
>  2.6.13:
>
>  - all the DVB patches
>
>  - all the v4l patches
>
>- Anything which you think needs to go into 2.6.13, please let me know.
>
>
>dvb-frontend-add-driver-for-lgdt3302.patch
>  dvb: frontend: add driver for LGDT3302
>
>v4l-cx88-update.patch
>  v4l: cx88 update
>  
>
This (v4l-cx88-update.patch) can go to 2.6.13 whenever you are ready.

>v4l-cx88-hue-offset-fix.patch
>  v4l: cx88 hue offset fix
>  
>
This (v4l-cx88-hue-offset-fix.patch) should be merged into 2.6.13 
immediately -- It is a one-line fix that corrects a bug that causes 
incorrect hue settings behavior in all cx88 chips.  It is also in Chris 
Wright's stable patch queue.

>v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-q.patch
>  v4l: add DVB support for DViCO FusionHDTV3 Gold-Q
>
>v4l-add-terratec-cinergy-1400-dvb-t.patch
>  v4l: add TerraTec Cinergy 1400 DVB-T
>
>v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-t.patch
>  v4l: add DVB support for DViCO FusionHDTV3 Gold-T
>
>v4l-lgdt3302-read-status-fix.patch
>  v4l: LGDT3302 read status fix
>  
>
This (v4l-lgdt3302-read-status-fix.patch) is actually a dvb patch.  
There are two v4l boards that use the lgdt3302 dvb frontend, and these 
are the only known (supported) boards to use lgdt3302 at this time.  
This patch should go to 2.6.13 whenever 
(dvb-frontend-add-driver-for-lgdt3302.patch) does, as it corrects a 
major bug.

Come to think of it, dvb-frontend-add-driver-for-lgdt3302.patch is 
pretty much useless without the following patches:

v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-q.patch
v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-t.patch
v4l-lgdt3302-read-status-fix.patch

...so whenever the lgdt3302 stuff is going into 2.6.13, all four of these patches should go together.


Thank you!

-- 
Michael Krufky

