Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310494AbSCCBKq>; Sat, 2 Mar 2002 20:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310495AbSCCBKh>; Sat, 2 Mar 2002 20:10:37 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:44549
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S310494AbSCCBKY>; Sat, 2 Mar 2002 20:10:24 -0500
Message-Id: <5.1.0.14.2.20020302200004.01da4790@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 02 Mar 2002 20:05:32 -0500
To: erich@uruk.org, Russell King <rmk@arm.linux.org.uk>
From: Stevie O <stevie@qrpff.net>
Subject: Re: Network Security hole (was -> Re: arp bug ) 
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16hKBV-0000wK-00@trillium-hollow.org>
In-Reply-To: <Your message of "Sat, 02 Mar 2002 16:43:23 PST." <E16hK5z-0000vI-00@trillium-hollow.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:49 PM 3/2/2002 -0800, erich@uruk.org wrote:

>Whoops, I am apparently using "ipchains" and not "iptables", and
>didn't note the distinction.
>
>Sorry about the spurious bug report here.  :/

Yeah, I use 2.2.19 on my server (2.4.x is the most unstable 'stable series' i've ever seen..). ipchains is like this:

Incoming                                                 Outgoing
interface                                                interface
  ----+                                             +------->
      |                                             ^
      v   +------------> forward -----------+      |
    input |                                 |----> output
          +----------> Application ---------+

I actually like it that way, it makes it easier to block things from the dsl ether (eth0):

ipchains -a input -i eth0 -d ! 66.92.237.176 -j DENY -l

With iptables i'd need that on both the INPUT *and* FORWARD rules...


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

