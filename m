Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129473AbRBZSDl>; Mon, 26 Feb 2001 13:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRBZSDa>; Mon, 26 Feb 2001 13:03:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:643 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129492AbRBZSDW>; Mon, 26 Feb 2001 13:03:22 -0500
Date: Mon, 26 Feb 2001 13:02:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jakub@redhat.com, David <dllorens@lsi.uji.es>,
        linux-kernel@vger.kernel.org
Subject: Re: Posible bug in gcc
In-Reply-To: <E14XRyY-0001gE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010226130127.5731A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Alan Cox wrote:

> > > Well gcc-bugs would be the better place to send it but this is a known problem
> > > fixed in CVS gcc 2.95.3, CVS gcc 3.0 branch and gcc 2.96 (unofficial, Red Hat)
> > 
> > I'm not sure if it is known, at least not known to me, but definitely not
> > fixed in any of gcc 2.95.2, CVS gcc 3.0 branch, CVS gcc 3.1 head, gcc 2.96-RH.
> 
> Sorry my error for assuming it was the exsting known strength reduce bug
> 

Script started on Mon Feb 26 12:54:20 2001
# gcc -o xxx bug.c
# ./xxx
Correct output: 5 2
GCC output:  5 2
# gcc --version
egcs-2.91.66
# gcc -O2 -o xxx bug.c
# ./xxx
Correct output: 5 2
GCC output:  10 5
# exit
exit

Script done on Mon Feb 26 12:55:21 2001

Definitely has something to do with broken optimization. No optimization,
no bug, turn on '-O2' and you have the bug.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


