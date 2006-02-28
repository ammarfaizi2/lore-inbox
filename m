Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWB1UsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWB1UsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWB1UsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:48:05 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:13998 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932575AbWB1UsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:48:04 -0500
Date: Tue, 28 Feb 2006 21:48:50 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: 2.6.16-rc5-mm1
Message-ID: <20060228204850.GB4286@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>
References: <20060228042439.43e6ef41.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228042439.43e6ef41.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc4-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 04:24:39AM -0800, Andrew Morton wrote:
[...]
> +mips-fixed-collision-of-rtc-function-name.patch
> +rtc-subsystem-library-functions.patch
> +rtc-subsystem-class.patch
> +rtc-subsystem-class-fix.patch
> +rtc-subsystem-class-fix-2.patch
> 
>  Updated rtc subsystem patches

in drives/Makefile the line

obj-$(CONFIG_RTC_CLASS)		+= /rtc

causes the missing symbols
WARNING: /lib/modules/2.6.16-rc5-mm1-1/kernel/drivers/rtc/rtc-test.ko needs unknown symbol rtc_time_to_tm
WARNING: /lib/modules/2.6.16-rc5-mm1-1/kernel/drivers/rtc/rtc-core.ko needs unknown symbol rtc_valid_tm
WARNING: /lib/modules/2.6.16-rc5-mm1-1/kernel/drivers/rtc/rtc-sysfs.ko needs unknown symbol rtc_tm_to_tim

when CONFIG_RTC_*=m. Maybe obj-y is nedded instead?

-- 
mattia
:wq!
