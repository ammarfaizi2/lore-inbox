Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRK0OBK>; Tue, 27 Nov 2001 09:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRK0OBA>; Tue, 27 Nov 2001 09:01:00 -0500
Received: from apollo.sot.fi ([195.74.13.237]:38661 "HELO vscan.sot.com")
	by vger.kernel.org with SMTP id <S279768AbRK0OAz>;
	Tue, 27 Nov 2001 09:00:55 -0500
Date: Tue, 27 Nov 2001 16:00:52 +0200 (EET)
From: Yaroslav Popovitch <yp@sot.com>
To: Joachim Backes <backes@rhrk.uni-kl.de>
Cc: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12 ... 2.4.16, /dev/tty
In-Reply-To: <XFMail.20011127085220.backes@rhrk.uni-kl.de>
Message-ID: <Pine.LNX.4.10.10111271558131.20830-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: Scanned by SOT's EVP service http://www.sot.fi/evp/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I also tested my 2.4.10-17 for tty bug,it was there.And I found that bug
exists if I do the full installation of our distributive.

> Hi,
> 
> still having problems (starting with kernel 2.4.12) with
> the /dev/tty device:
> 
> When logging in on the console and trying the "ps" command,
> is will list  _all_ processes and not only those which are
> attached to the controlling terminal. This seemed a little
> bit suspicious.
> 
> Now, trying
> 
>         echo some text >/dev/tty
> 
> returns 
> 
>         bash: /dev/tty: No such device or address
> 
> Now trying the command
> 
>         tty
> 
> says 
> 
>         /dev/tty1
> 
> Now, I tried
> 
>         echo some text >/dev/tty1
> 
> It echoed correctly
> 
>         some text
> 
> on the console.
> 
> Then, I tried
> 
>         echo some text >/dev/tty
> 
> Now (!!!???) it echoes correctly "some text".
> 
> It seems that the cmd
> 
>         echo some text > `tty`
> 
> will repair something, but I don't no what and why.
> 
> -----------------------------------------------------
> 
> The above described problem first appeared with Kernel 2.4.12,
> I tried the following kernels (now 2.4.16), BUT WITH NO SUCCESS.
> Kernel 2.4.10 was _not buggy_.
> 
> Additionally, the problem does not arise on all my LINUX workstations,
> but only on some. And it does not depend on the harware platform.
> And is does not depend on the distribution. Both on RedHat 7.1 ans
> Redhat 7.2 having the problem.
> 
> Regards
> 
> 
> Joachim Backes
> 
> --
> 
> Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
> Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
> D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
> ---------------------------------------------+------------------------
> WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

