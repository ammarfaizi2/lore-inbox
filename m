Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262461AbSJ0QhG>; Sun, 27 Oct 2002 11:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSJ0QhF>; Sun, 27 Oct 2002 11:37:05 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:11975 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id <S262461AbSJ0QhE>;
	Sun, 27 Oct 2002 11:37:04 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/serial/core.c:1067 with 2.5.44
References: <87elabdf1q.fsf@sycorax.lbl.gov>
	<20021027163307.A9553@flint.arm.linux.org.uk>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: 27 Oct 2002 08:43:07 -0800
In-Reply-To: <20021027163307.A9553@flint.arm.linux.org.uk> (message from Russell King on Sun, 27 Oct 2002 16:33:07 +0000)
Message-ID: <87adkzde90.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Sun, Oct 27, 2002 at 08:25:53AM -0800, Alex Romosan wrote:
> > Oct 27 07:39:54 trinculo kernel: kernel BUG at drivers/serial/core.c:1067!
> 
> Someone called uart_set_termios without the BKL held, violating the locking
> requirements.
> 
> Unfortunately:
> 
> 1. You appear to be running a klogd that'll translate the addresses.

i am not sure what this means. i am running debian unstable. i just
realized i ran ksymoops with the -x option (if it makes any difference
i can resend the oops without -x).

> 2. your ksymoops doesn't seem to know what modules are loaded.

isn't this the list of modules loaded at the time?

Oct 27 07:39:54 trinculo kernel: 3c574_cs irtty irda autofs4 microcode ppp_async uhci-hcd ohci-hcd usbcore nls_cp437 vfat snd-pcm-oss snd-mixer-oss snd-ymfpci snd-pcm snd-mpu401-uart snd-rawmidi snd-ac97-codec snd-opl3-lib snd-timer snd-hwdep snd-seq-device snd soundcore

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
