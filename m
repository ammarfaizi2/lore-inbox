Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUJPJFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUJPJFV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 05:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268695AbUJPJFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 05:05:20 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:4782 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268690AbUJPJE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 05:04:57 -0400
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
	card BOOT?
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
In-Reply-To: <20041015112902.A12631@unix-os.sc.intel.com>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org>
	 <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
	 <20041015112902.A12631@unix-os.sc.intel.com>
Content-Type: text/plain
Message-Id: <1097917295.4763.35.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 16 Oct 2004 19:01:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-10-16 at 04:29, Venkatesh Pallipadi wrote:
> > Why not? Of course you won't get any output before the graphics card has been
> > re-initialized to a sane and usable state...
> > 
> 
> True. I do it on my Dell 600m (Radeon 9000M) using usermodehelper and
> it works just fine. It works both with VGA and X. I need to split up
> the thaw_processes into two stages though. It may not work with fb as
> fb driver resumes earlier. I use the patch below for the kernel and a
> userlevel x86 emulator.
> 
> I have to say though, it will help if we have a such an emulator in the kernel.

Just a quick question: is this the right way to distinguish kernel
threads? I've been checking if the process has an mm context (if p->mm).

> +		if (p->parent->pid != 1)
> +			continue;

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

