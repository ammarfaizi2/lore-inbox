Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264345AbRF3Wxv>; Sat, 30 Jun 2001 18:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264511AbRF3Wxm>; Sat, 30 Jun 2001 18:53:42 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:65098 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S264345AbRF3Wxb>;
	Sat, 30 Jun 2001 18:53:31 -0400
Message-ID: <20010701005334.A26841@win.tue.nl>
Date: Sun, 1 Jul 2001 00:53:34 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Rudolf Polzer <rpolzer@durchnull.de>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: drivers/char/vt.c allows virtually locking up nonnetworked machine
In-Reply-To: <20010630231040.A3501@www42.durchnull.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010630231040.A3501@www42.durchnull.de>; from Rudolf Polzer on Sat, Jun 30, 2001 at 11:10:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 11:10:40PM +0200, Rudolf Polzer wrote:
> There is a problem concerning chvt. A normal user can run a
> 
> bash$ while [ 1 ]; do chvt 11; done
> 
> which cannot be killed using the console (only remotely, virtually never
> on a nonnetworked multiuser machine). So I changed the kernel source code
> so that only the superuser may change terminals.

The person at the console on a nonnetworked machine
can make life difficult for himself in a great variety of ways.
(E.g., try running
  #include <signal.h>
  main(){int i;for(i=1; i<32; i++)signal(i,SIG_IGN); while(1);}
on all VTs.)

It would not increase security when root privileges were needed
in all such cases.

Andries
