Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271574AbRIFRjr>; Thu, 6 Sep 2001 13:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271557AbRIFRjh>; Thu, 6 Sep 2001 13:39:37 -0400
Received: from spike.porcupine.org ([168.100.189.2]:41481 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S271569AbRIFRj2>; Thu, 6 Sep 2001 13:39:28 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
 bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> "from Andrey Savochkin
 at Sep 6, 2001 09:23:03 pm"
To: Andrey Savochkin <saw@saw.sw.com.sg>
Date: Thu, 6 Sep 2001 13:39:48 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906173948.502BFBC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin:
> > That is not practical. Surely there is an API to find out if an IP
> > address connects to the machine itself. If every UNIX system on
> > this planet can do it, then surely Linux can do it.
> 
> Let me correct you: you need to recognize not addresses that result in
> connecting to the _machine_ itself, but connecting to the same _MTA_.

The SMTP RFC requires that user@[ip.address] is correctly recognized
as a final destination.  This requires that Linux provides the MTA
with information about IP addresses that correspond with INADDR_ANY.

I am susprised that it is not possible to ask such information up
front (same with netmasks), and that an application has to actually
query a complex oracle, again and again, for every IP address.

	Wietse
