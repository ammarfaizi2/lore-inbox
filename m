Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289103AbSA1Dkl>; Sun, 27 Jan 2002 22:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289105AbSA1DkV>; Sun, 27 Jan 2002 22:40:21 -0500
Received: from harddata.com ([216.123.194.198]:33040 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S289103AbSA1DkR>;
	Sun, 27 Jan 2002 22:40:17 -0500
Date: Sun, 27 Jan 2002 20:40:02 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Michal Jaegermann <michal@harddata.com>, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
Subject: Re: CRAP in 2.4.18-pre7
Message-ID: <20020127204002.A5220@mail.harddata.com>
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C52E671.605FA2F3@mandrakesoft.com> <3C540A90.5020904@evision-ventures.com> <20020127114642.A2288@mail.harddata.com> <20020127225845.1bc1453a.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020127225845.1bc1453a.skraw@ithnet.com>; from skraw@ithnet.com on Sun, Jan 27, 2002 at 10:58:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 10:58:45PM +0100, Stephan von Krawczynski wrote:
> On Sun, 27 Jan 2002 11:46:42 -0700
> Michal Jaegermann <michal@harddata.com> wrote:
> 
> > Well, from what I know 'tulip' driver in later 2.4 kernels simply does
> > NOT work with any of my tulip cards, on x86 or on alpha,

> Hm, maybe you should shortly state which vendor (OEM or the like) you are
> using.

Ok, how about these:

# lspci -v -s 2:5.0
02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
	Flags: bus master, medium devsel, latency 96, IRQ 3
	I/O ports at c400 [size=128]
	Memory at db002000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

# lspci -n -s 2:5.0
02:05.0 Class 0200: 1011:0019 (rev 41)

and (another machine runing something "old" at the moment):

# lspci -v -s 0:5.0
00:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
        Subsystem: Unknown device 1025:0310
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at 8000
        Memory at 0000000004200000 (32-bit, non-prefetchable)

# lspci -n -s 0:5.0
00:05.0 Class 0200: 1011:0009 (rev 22)

This is what I happen to have on hands right now.

> I generally cannot confirm any problems with tulip-driver in 2.4.

Lucky you!  The same goes for me if you do s/2.4/2.2/. :-)

> Maybe this is a specific problem with a certain vendor or board type?

Well, the vendor seems to be tulip designers and for a board type I had
exactly the same results with various x86 and Alpha boards.

If you will search through linux-kernel archives you will notice that
some people were able to restart a network with 2.4 tulip drivers by
unplugging a cable and plugging it back.  Even this trick does not work
in my case.  Yes, I am aware about negotiation troubles with tulips.
Forcing speed also does not help. 'de4x5' is still fine or you will be
not reading this. :-)

  Michal

