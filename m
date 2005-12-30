Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVL3O11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVL3O11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 09:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVL3O11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 09:27:27 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:4308 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932149AbVL3O10 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 09:27:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rbW7Fc3sKkm3KR1jR6pLYfjmMoOj6vcn4bjsDNiguS/xpNZoazpMpVvlGhbltAhybXKNkynP/b875nk/2JzxXdvlzz49eqOEXWm1XNC9wiSQ83lZ/8Spin8+2FljG7faJaE66iwHz1vfAZ/ElB9tNmOJu59GP6tziw2yyKS3zPE=
Message-ID: <9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com>
Date: Fri, 30 Dec 2005 15:27:26 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Trilight <trilight@ns666.com>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43B53EAB.3070800@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B53EAB.3070800@ns666.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Trilight <trilight@ns666.com> wrote:
> Hiya,
>
> I'm using the 2.6.14.5 kernel and i notice that the system freezes
> sometimes, within 24 hours usually, a total freeze, no mouse/keyb
> reaction. Also i notice that apps crash randomly sometimes.
>
When did this start to happen? Was it OK with a previous kernel
version? if it was ok with a previous version, then what was that
version?
Was it OK before you added a particular piece of hardware? If so, what
hardware? Have you tried removing that hardware to see if the problem
goes away?

> What can i do to investigate this ?
>
A few things you can try :

1) Start by providing some more info. Some details on your
hardware/software. Something like the following + whatever else you
consider relevant :
 - name and version of your Linux distribution
 - output of the  scripts/ver_linux  script found in the kernel source
 - your kernels .config file
 - full  dmesg  output after boot
 - Motherboard name/model
 - output of  cat /proc/cpuinfo
 - output of  cat /proc/meminfo
 - output of  lspci -vv
 - output of  lsusb

2) Tell us what you have already tried in order to try and resolve the
problem, including your results with the various things you've tried.

3) Try building/running a kernel with the various debug options found
in the kernel hacking section turned on and see if that results in
more details in dmesg/logs etc and provide the extra info if any.

4) Try building a 2.6.15-rc7-git4 kernel with the same config and see
if that one also has problems.

Make sure your hardware is OK, CPU not overheating, RAM is OK (run
memtest86 with all tests enabled overnight) etc.

Try removing all extra hardware components in your system you don't
need for the system to boot and see if the problem then goes away. If
it does, try adding back hardware one piece at a time and re-test,
find out if it's related to a certain piece of hardware or a specific
driver.

That's all I can think of atm. With more info provided (as pr the list
above) perhaps someone else can point to more (or better) things to
try.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
