Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271502AbRIFRX1>; Thu, 6 Sep 2001 13:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271515AbRIFRXR>; Thu, 6 Sep 2001 13:23:17 -0400
Received: from spike.porcupine.org ([168.100.189.2]:39945 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S271502AbRIFRW5>; Thu, 6 Sep 2001 13:22:57 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
In-Reply-To: <E15f2WT-0008Tp-00@the-village.bc.nu> "from Alan Cox at Sep 6, 2001
 06:01:01 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 6 Sep 2001 13:23:16 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906172316.E0B74BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> How for example do you propose to answer the question for the case
> Q: "is this local" A: "it depends on the sender"
> With netfilter and transparent proxying active this is entirely possible

Please explain the relevance for a real-world, SMTP based, MTA.

If an MTA receives a delivery request for user@[ip.address] then
the MTA has to decide if it is the final destination. This is
required by the SMTP RFC.

In order to enable SMTP RFC compliance, Linux has to provide the
MTA with the necessary information.  Requiring the sysadmin to
enumerate all IP addresses in a file, as suggested by some other
poster, is impractical.

If an MTA receives a mail relaying request for user@domain.name
then it would be very useful if Linux could provide the MTA with
the necessary information to distinguish between local subnetworks
and the rest of the world. Requiring the local sysadmin to enumerate
all local subnetwork blocks by hand is not practical.

I will ignore denigrating comments about competing IP stacks.

	Wietse
