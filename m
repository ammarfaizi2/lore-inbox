Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264080AbRGCLtz>; Tue, 3 Jul 2001 07:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264092AbRGCLte>; Tue, 3 Jul 2001 07:49:34 -0400
Received: from viper.haque.net ([66.88.179.82]:2199 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S264080AbRGCLt3>;
	Tue, 3 Jul 2001 07:49:29 -0400
Message-ID: <3B41B146.7669DF58@haque.net>
Date: Tue, 03 Jul 2001 07:49:26 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Blesson Paul <blessonpaul@usa.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel still resides in the root
In-Reply-To: <20010703054924.20200.qmail@nwcst340.netaddress.usa.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blesson Paul wrote:
>                 I just completed the full compilation. But there is one still
> missing factor. I uncommented the INSTALL_PATH=/boot. But still the vmlinux
> still resides in the directory where i compiled the kernel. Why is it so. What
> to do if the kernel should be present in the boot directory.

You did run make install? Do you have a custom install script in
/sbin/installkernel?

The vmlinux you see is the uncompressed kernel. If you compiled with
make bzImage, zImage, etc the resulting compressed kernel is at
arch/<your arch>/boot/. You then either run make install or 
	cp ./System.map arch/<your arch>/boot/<kernel> /boot 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
