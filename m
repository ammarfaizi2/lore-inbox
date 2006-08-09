Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWHISTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWHISTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWHISTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:19:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:61078 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750705AbWHISTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:19:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XSvqhf+t295wpwhZBV+HcL/mkfjky400mfqd51fDVkPMghH/R/xUJKVtaE0vALH0wL+HFGvN1fgJZN9UnOJ3iJa73pyeJM7H9/xLgq+cwNI6KSuwfepkPSB4+qtZy2+auvG9hFrrTfJqceoFrzHxNxZNG3N9F59t9QP0+HOICto=
Message-ID: <5a4c581d0608091117l45aa4b33n4fe0d134a413e96d@mail.gmail.com>
Date: Wed, 9 Aug 2006 20:17:42 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 doesn't load firmware on battery-powered boot
In-Reply-To: <5a4c581d0608091105r2e43bd9bx1bd78b2280dca13b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0608091105r2e43bd9bx1bd78b2280dca13b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> Dell Latitude D610, FC5, happens at least since 2.6.18-rc2 and
>  it's fully reproducable. Sorry for not reporting earlier but I've been
>  recently either on vacation or very busy...
>
> Booting with AC always makes interface eth1 appear:
>
> Aug  8 21:32:48 sandman kernel: ipw2200: Intel(R) PRO/Wireless
> 2200/2915 Network Driver, 1.1.2kmpr
> Aug  8 21:32:48 sandman kernel: ipw2200: Copyright(c) 2003-2006 Intel
> Corporation
> Aug  8 21:32:49 sandman kernel: ipw2200: Detected Intel PRO/Wireless
> 2200BG Network Connection
> Aug  8 21:32:49 sandman kernel: ipw2200: Detected geography ZZD (13
> 802.11bg channels, 0 802.11a channels)
>
> Booting without AC always fails to load firmware:
>
> Aug  9 19:06:01 sandman kernel: ipw2200: Intel(R) PRO/Wireless
> 2200/2915 Network Driver, 1.1.2kmpr
> Aug  9 19:06:01 sandman kernel: ipw2200: Copyright(c) 2003-2006 Intel
> Corporation
> Aug  9 19:06:01 sandman kernel: ipw2200: Detected Intel PRO/Wireless
> 2200BG Network Connection
> Aug  9 19:06:01 sandman kernel: ipw2200: ipw2200-bss.fw
> request_firmware failed: Reason -2
> Aug  9 19:06:01 sandman kernel: ipw2200: Unable to load firmware: -2
> Aug  9 19:06:01 sandman kernel: ipw2200: failed to register network device
> Aug  9 19:06:01 sandman kernel: ipw2200: probe of 0000:03:03.0 failed
> with error -5
>
> A post-boot modprobe -r ipw2200; modprobe ipw2200 makes eth1
>  appear even on battery power:
>
> Aug  9 19:14:36 sandman kernel: ieee80211: 802.11
> data/management/control stack, git-1.1.13
> Aug  9 19:14:36 sandman kernel: ieee80211: Copyright (C) 2004-2005
> Intel Corporation <jketreno@linux.intel.com>
> Aug  9 19:14:36 sandman kernel: ipw2200: Intel(R) PRO/Wireless
> 2200/2915 Network Driver, 1.1.2kmpr
> Aug  9 19:14:36 sandman kernel: ipw2200: Copyright(c) 2003-2006 Intel
> Corporation
> Aug  9 19:14:36 sandman kernel: ACPI: PCI Interrupt 0000:03:03.0[A] ->
> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
> Aug  9 19:14:36 sandman kernel: ipw2200: Detected Intel PRO/Wireless
> 2200BG Network Connection
> Aug  9 19:14:36 sandman kernel: ipw2200: Detected geography ZZD (13
> 802.11bg channels, 0 802.11a channels)
> Aug  9 19:14:36 sandman kernel: eth1: NETDEV_TX_BUSY returned; driver
> should report queue full via ieee_device->is_queue_full.
>
> The above log snippets are from 2.6.18-rc4 kernels; full boot logs
>  from both cases attached.

Right, so I managed to save logs as root, perm 600, and try and
 attach them as non-root and got not even a warning from either
 Firefox or the GMail interface. Tsk, tsk.

In any case, I now put them up here:

http://xoomer.alice.it/incident/messages-boot-ac.log
http://xoomer.alice.it/incident/messages-boot-battery.log

Sorry for the double message. Thanks,

--alessandro

"What's the name of the word for the precise moment when you
 realize that you've actually forgotten how it felt to make love
 to somebody you really liked a long time ago?"
"There isn't one."
"Oh. I thought maybe there was."
     (The Sandman, dialogue between Delirium and Dream)
