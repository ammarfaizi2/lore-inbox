Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSJ0RGh>; Sun, 27 Oct 2002 12:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbSJ0RGh>; Sun, 27 Oct 2002 12:06:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26885 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262395AbSJ0RGg>; Sun, 27 Oct 2002 12:06:36 -0500
Date: Sun, 27 Oct 2002 17:12:53 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/serial/core.c:1067 with 2.5.44
Message-ID: <20021027171253.B9553@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Romosan <romosan@sycorax.lbl.gov>,
	linux-kernel@vger.kernel.org
References: <87elabdf1q.fsf@sycorax.lbl.gov> <20021027163307.A9553@flint.arm.linux.org.uk> <87adkzde90.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87adkzde90.fsf@sycorax.lbl.gov>; from romosan@sycorax.lbl.gov on Sun, Oct 27, 2002 at 08:43:07AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 08:43:07AM -0800, Alex Romosan wrote:
> i am not sure what this means. i am running debian unstable. i just
> realized i ran ksymoops with the -x option (if it makes any difference
> i can resend the oops without -x).

Firstly, you need klogd running with -x so the numbers within [< and >]
are preserved.  It is a shame that these distributions still run klogd
without -x.

> > 2. your ksymoops doesn't seem to know what modules are loaded.
> 
> isn't this the list of modules loaded at the time?
> 
> Oct 27 07:39:54 trinculo kernel: 3c574_cs irtty irda autofs4 microcode
> ppp_async uhci-hcd ohci-hcd usbcore nls_cp437 vfat snd-pcm-oss
> snd-mixer-oss snd-ymfpci snd-pcm snd-mpu401-uart snd-rawmidi
> snd-ac97-codec snd-opl3-lib snd-timer snd-hwdep snd-seq-device
> snd soundcore

This is a line from the kernel which ksymoops can't interpret.

ksymoops needs to know which modules are loaded, and where they
are loaded so it can give accurate call trace information.

BTW, an even better option would be to enable CONFIG_KALLSYMS.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

