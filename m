Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287429AbRL3PSA>; Sun, 30 Dec 2001 10:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287430AbRL3PRu>; Sun, 30 Dec 2001 10:17:50 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:34282 "HELO
	dardhal") by vger.kernel.org with SMTP id <S287429AbRL3PRn>;
	Sun, 30 Dec 2001 10:17:43 -0500
Date: Sun, 30 Dec 2001 16:17:33 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Out of Memory: Killed process pine, find, kza ...
Message-ID: <20011230151732.GA1659@localhost>
Mail-Followup-To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.43.0112301550150.2297-100000@LiSa>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.43.0112301550150.2297-100000@LiSa>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 30 December 2001, at 15:57:38 +0100,
Michael De Nil wrote:

> I have a strange problem with kernel 2.4.14 & 2.4.17 (the two I tried on)
> When I run a simple command like 'find /var -name sendmail* -print' (this
> one) or when running pine, kza, etc. Iget the error: 'Out of Memory:
> Killed process 2032 (find)'
> I did a vmstat 2 while running 'find /var -name sendmail* -print'
> Here is what I recieved after a while:
> 
> cs                      memory    swap          io     system         cpu
> r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> 6  0  2 205720   1408   1220   5176   0 1664    12  1682  332    67   6  93   1
> [...]
> 1  0  0 240964   1328   1224   5000   0 924    10   924  231    71   8  92   0
> Out of Memory: Killed process 2032 (find).
> 
> 
It doesn't seem to be the problem some people is complaining about
lately. These people get OOM but their systems still have tons of
"available" memory in buffers and/or caches. This is not your case, and
it seems OOM kills a process just in time to avoid having no memory
available for the system to continue working.

I would run "top" and see what processes are eating up your memory,
because 128 MB RAM + 256 MB swap is more than enough for a "normal"
system. Maybe is a program that went crazy, and keeps on allocating all
your memory, leaving nothing for the rest. I have seen both X and
netscape processes behaving this way.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

