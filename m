Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130460AbRA0SzO>; Sat, 27 Jan 2001 13:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132794AbRA0Syy>; Sat, 27 Jan 2001 13:54:54 -0500
Received: from mail.diligo.fr ([194.153.78.251]:44557 "EHLO mail.diligo.fr")
	by vger.kernel.org with ESMTP id <S130460AbRA0Syw>;
	Sat, 27 Jan 2001 13:54:52 -0500
Date: Sat, 27 Jan 2001 19:52:32 +0100
From: patrick.mourlhon@wanadoo.fr
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SBF queueing?
Message-ID: <20010127195232.B1326@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
In-Reply-To: <20010127134448.B6821@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010127134448.B6821@xi.linuxpower.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory!

You might have a look on linux/Documentation/networking/policy-routing.txt

I think this was down by Alexey Kuznetov

You might have a look to iproute + tc and HOWTO on advanced networking

patrick mourlhon

On Sat, 27 Jan 2001, Gregory Maxwell wrote:

> Has anyone decided to code a SFB (Stochastic Fair Blue) queue implementation
> for Linux? It's been implemented for FreeBSD/ALTQ 
> (http://www.eecs.umich.edu/~wuchang/blue/). The paper for it shows it
> performing very well in comparison to RED.
> 
> It might be useful in a Linux implementation to be able to adjust what
> fields are hashed (I don't believe the initial implementation does this,
> though it has been a few months since I read the paper). 
> 
> For instance, on edge networks you hash src,dest,proto,sport,dport to
> allocate fairly by flow. On larger networks, hashing on each flow will
> require a fairly big filter to prevent collisions from punishing good flows
> because of a collision with an unresponsive flow. It might be useful to only
> hash on src on core networks, and potentially masked src on backbone transit
> networks (which would have nice social implications as well, produce an
> unresponsive flow and watch your entire subnet be slowed during networking
> congestion, thus edge networks would implement technology to detect and
> police unresponsive flows, something better done towards the edge). 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
