Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279882AbRJ3HCJ>; Tue, 30 Oct 2001 02:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279881AbRJ3HCA>; Tue, 30 Oct 2001 02:02:00 -0500
Received: from suphys.physics.usyd.edu.au ([129.78.129.1]:7615 "EHLO
	suphys.physics.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S279880AbRJ3HBp>; Tue, 30 Oct 2001 02:01:45 -0500
Date: Tue, 30 Oct 2001 18:02:07 +1100 (EST)
From: Tim Connors <tcon@Physics.usyd.edu.au>
To: Marko Rauhamaa <marko@pacujo.nu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
In-Reply-To: <20011030035221.6E5611FE7D@varmo.pacujo.nu>
Message-ID: <Pine.SOL.3.96.1011030180024.12360A-100000@suphys.physics.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Marko Rauhamaa wrote:

> > > I noticed that I need a pseudodevice that opens normally but blocks all
> > > reads (and writes). The only way out would be through a signal. Neither
> > 
> > Try using a pipe
> 
> You're right. This is what I wanted to do:
> 
>    while true
>    do
>        ssh -R a:b:c host
>        sleep 10
>    done </dev/never >/dev/null
> 
> But I could do it like this:
> 
>    while true
>    do
>        sleep 100000
>    done |
>    while true
>    do
>        ssh -R a:b:c host
>        sleep 10
>    done >/dev/null

Highly elegant :)

How bout just `mkfifo /tmp/blockme`
and read on /tmp/blockme - just don't write to it!

-- 
TimC -- http://www.physics.usyd.edu.au/~tcon/

> cat ~/.signature
CPU time limit exceeded (core dumped)

