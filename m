Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284304AbRLXCBr>; Sun, 23 Dec 2001 21:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbRLXCBg>; Sun, 23 Dec 2001 21:01:36 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:5104 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S284304AbRLXCB0>;
	Sun, 23 Dec 2001 21:01:26 -0500
Date: Mon, 24 Dec 2001 13:00:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] a bit smarter dmi-scan.c
Message-Id: <20011224130055.32113ef8.sfr@canb.auug.org.au>
In-Reply-To: <3C26255B.70AE386A@sltnet.lk>
In-Reply-To: <3C26255B.70AE386A@sltnet.lk>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 23 Dec 2001 12:41:31 -0600
Ishan Oshadi Jayawardena <ioshadi@sltnet.lk> wrote:
>
> --- src/linux/arch/i386/kernel/dmi_scan.c       Sat Dec 22 16:31:11 2001
> +++ src/linux/arch/i386/kernel/dmi_scan.c.mod   Sat Dec 22 17:06:22 2001
> @@ -255,26 +255,29 @@
>  
>  static __init int set_realmode_power_off(struct dmi_blacklist *d)
>  {
> +#if defined (CONFIG_APM)

APM can also be compiled as a module.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
