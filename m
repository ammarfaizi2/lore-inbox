Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUGJCCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUGJCCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 22:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUGJCCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 22:02:11 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20723 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266081AbUGJCCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 22:02:09 -0400
Message-ID: <40EF4E16.8000709@mvista.com>
Date: Fri, 09 Jul 2004 19:01:58 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: Tim Bird <tim.bird@am.sony.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
References: <40EEF10F.1030404@am.sony.com> <20040709193528.A23508@mail.kroptech.com> <40EF3637.4090105@am.sony.com> <20040709220142.B29198@mail.kroptech.com>
In-Reply-To: <20040709220142.B29198@mail.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:

> +	if (preset_lpj) {
> +		loops_per_jiffy = preset_lpj;
> +		printk("Calibrating delay loop (skipped)... ");

Suggest a "\n" at the end of that.  Maybe add the precomputed value to 
help bring incorrect presets to someone's attention, something like:

+		printk("BogoMIPS preset to %lu.%02lu\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100);

 > + If unsure, set this to 0. An incorrect value will cause delays in
 > + the kernel to be incorrect.  Although unlikely, in the extreme case
 > + this might damage your hardware.

I suppose it may result in unpredictable I/O errors, in case we want to 
warn against that.


-- 
Todd Poynor
MontaVista Software
