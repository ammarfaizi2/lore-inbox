Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbUEGJQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUEGJQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 05:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUEGJQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 05:16:06 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:31148
	"HELO fargo") by vger.kernel.org with SMTP id S263370AbUEGJQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 05:16:03 -0400
Date: Fri, 7 May 2004 11:16:00 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: linux-kernel@vger.kernel.org
Subject: Re: events kthread gone crazy
Message-ID: <20040507091559.GA1166@fargo>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040506211934.GA1452@fargo> <20040506213450.GA11761@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040506213450.GA11761@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ;),

> > I'm running kernel 2.6.5. I had running aMule and decided to preview
> > a file, using xine. Then, suddenly, xine opened but hanged and the
> > machine started to feel unresponsive and sluggish. I guessed that
> > the xine process was in D state, so i did a 'ps' and found this mess:
> [...]
> > 11569 ?        SW<    0:00  \_ [events/0]
> > 11570 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
> > 11571 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
> [Ad infinitum]
> 
>     It seems that ALSA is screwing something. Maybe you need to
> recompile ALSA binaries or something like that :???

I think i know the cause of the problem, i'll test it later. You had
to be careful with 'install' directives in modprobe.conf to not cause
circular dependencies, and i think maybe this is the problem. But this
shouldn't trash the kernel with a lot of processes in D state that 
cannot be killed...

> >    85 tty3     S      0:00 into           
> 
>     What the hell is that crap? X''DDDD

A init/login/getty clone programmed by some crazy bastard XDDD

>     Have you seen where xine is disk sleeping. It should not matter
> to the sound problem, but...

I was wrong, xine and aMule had nothing to do with the problem. Just a
'modprobe snd' triggers the problem.

bye

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
