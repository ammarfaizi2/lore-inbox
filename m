Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282968AbRLQW0G>; Mon, 17 Dec 2001 17:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282966AbRLQWZ4>; Mon, 17 Dec 2001 17:25:56 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46343 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282959AbRLQWZn>; Mon, 17 Dec 2001 17:25:43 -0500
Date: Mon, 17 Dec 2001 19:10:54 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Samuli Suonpaa <suonpaa@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: Out of memory - when still more than 100MB free
In-Reply-To: <87elltwmgz.fsf@puck.erasmus.jurri.net>
Message-ID: <Pine.LNX.4.21.0112171909320.3767-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 Dec 2001, Samuli Suonpaa wrote:

> I've got VMWare killed a couple of times mysteriously. 
> 
> I've got 256MB memory and no swap on my laptop running 2.4.16 and for
> some reason VMWare has got killed with the following syslog
> information:
> 
> Dec 17 23:33:23 puck kernel: Out of Memory: Killed process 28803 (vmware).
> Dec 17 23:33:35 puck kernel: Out of Memory: Killed process 28804 (vmware).
> Dec 17 23:33:37 puck kernel: /dev/vmmon: Vmx86_ReleaseVM: unlocked pages: 75286, unlocked dirty pages: 51084

Samuli, 

The problem is that buffer/cache/{i,d}cache pages are not getting freed
easily, and instead the kernel swapouts anonymous memory.

Could you please try 2.4.17-rc1 and tell me if it makes a difference for
you ? 

Thanks

