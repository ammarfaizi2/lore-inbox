Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315155AbSDWLGQ>; Tue, 23 Apr 2002 07:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSDWLGP>; Tue, 23 Apr 2002 07:06:15 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26895 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315155AbSDWLGP>; Tue, 23 Apr 2002 07:06:15 -0400
Message-Id: <200204231102.g3NB2aX15231@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Frank Louwers <frank@openminds.be>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Date: Tue, 23 Apr 2002 14:05:02 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020423113935.A30329@openminds.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 April 2002 07:39, Frank Louwers wrote:
> Hi,
>
> We recently stummed across a rather annoying bug when 2 nics are on
> the same network.
>
> Our situation is this: we have a server with 2 nics, each with a
> different IP on the same network, connected to the same switch. Let's
> assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> netmask of 255.255.255.0.
>
> Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
> matter what!
>
> Even if we disconnect the cable for eth1, 1.2.3.2 still replies to
> pings, ssh, web, ...
>
> We tested this on IA32 architecture, different 2.4.x kernels and
> different nics ...
>
> Is this a bug or a known issue? If it is not a bug, how can it be
> solved?

Do you have ip forwarding enabled? If yes, kernel just forwards packets:
network -> eth0 -> kernel

Try traceroute to eth1' ip. Examine arp tables. What MAC is listed there for 
eth1 IP?
--
vda
