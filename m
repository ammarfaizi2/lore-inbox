Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSLPMIA>; Mon, 16 Dec 2002 07:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbSLPMIA>; Mon, 16 Dec 2002 07:08:00 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:41675 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266576AbSLPMH7>; Mon, 16 Dec 2002 07:07:59 -0500
Date: Tue, 17 Dec 2002 01:06:58 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: p&p ipsec without authentication
Message-ID: <8360000.1040040418@localhost.localdomain>
In-Reply-To: <atk5sr$a06$1@forge.intermeta.de>
References: <Pine.LNX.4.50L.0212151745360.2711-100000@imladris.surriel.com>
 <atk5sr$a06$1@forge.intermeta.de>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NAT traversal can be done, in some (limited) cases even without the 
cooperation of the NAT (although someone on the inside must cooperate). 
Firewalls do be a problem.  I think the best thing here is if you use this 
kind of thing outside the firewall; I always build networks, even LANs, 
with the crown jewels behind a firewall from the workstations, especially 
if they run Windows.  Authenticated IPSEC is a nice way to find out if we 
can to some extent trust them, although it costs cycles.

As for compatibility, there are three ways to do it presently in the IETF 
process (HIP, IKEv2 and FreeSWAN opportunistic mode), and two of them have 
running code on multiple platforms.

Andrew

--On Monday, December 16, 2002 09:20:27 +0000 "Henning P. Schmiedehausen" 
<hps@intermeta.de> wrote:

> Rik van Riel <riel@conectiva.com.br> writes:
>
>> Hi,
>
>> I've got a crazy idea.  I know it's not secure, but I think it'll
>> add some security against certain attacks, while being non-effective
>> against some others.
>
> While the idea itself is nice, it would allow many attackers on your
> host to "dive" under IDS systems or avoid stateful firewalls which do
> protocol verification. And IDS system is "a three letter acronym
> listening on your traffic". And you want to avoid that. =:-)
>
> It won't traverse many firewalls either (because they won't let IPSEC
> pass) and you might get in trouble with NAT and protocols that need
> NAT fixup.
>
> And you basically divide the Internet into "Linux <-> Linux" and "the
> rest". :-)
>
> 	Regards
> 		Henning

