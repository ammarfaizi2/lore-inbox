Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266328AbUGJSTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266328AbUGJSTp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUGJSTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:19:44 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:37760 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266328AbUGJSTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:19:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Date: Sat, 10 Jul 2004 13:19:30 -0500
User-Agent: KMail/1.6.2
Cc: Adam Kropelin <akropel1@rochester.rr.com>, Tim Bird <tim.bird@am.sony.com>,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>,
       Todd Poynor <tpoynor@mvista.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>
References: <40EEF10F.1030404@am.sony.com> <20040710115413.A31260@mail.kroptech.com> <20040710142800.A5093@mail.kroptech.com>
In-Reply-To: <20040710142800.A5093@mail.kroptech.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407101319.31147.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 01:28 pm, Adam Kropelin wrote:
> +         Note that on SMP systems the preset will be applied to all CPUs
> +         which will cause problems if for some reason your CPUs need
> +         significantly divergent settings.
> +
> +         If unsure, set this to 0. An incorrect value will cause delays in
> +         the kernel to be wrong, leading to unpredictable I/O errors and
> +         other breakage.  Although unlikely, in the extreme case this might
> +         damage your hardware.
> 

Note that it may also not work correctly on laptops that switch frequency
when working on battery/AC. Also one needs to be careful when changing
timesource (pit, tsc, pm, hpet). And always look out for timer code changes
in next version of kernel. Does 250 ms worth all this pain?

-- 
Dmitry
