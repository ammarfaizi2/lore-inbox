Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270847AbRIFOEs>; Thu, 6 Sep 2001 10:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270848AbRIFOE2>; Thu, 6 Sep 2001 10:04:28 -0400
Received: from spike.porcupine.org ([168.100.189.2]:23049 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S270847AbRIFOEY>; Thu, 6 Sep 2001 10:04:24 -0400
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <20010906173534.A21874@castle.nmd.msu.ru> "from Andrey Savochkin
 at Sep 6, 2001 05:35:34 pm"
To: Andrey Savochkin <saw@saw.sw.com.sg>
Date: Thu, 6 Sep 2001 10:04:44 -0400 (EDT)
Cc: Andi Kleen <ak@suse.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, Wietse Venema <wietse@porcupine.org>
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906140444.75DC1BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin:
> > Even if it checked the address it would not be unique because you can have multiple
> > interfaces with the same addresses but different netmasks.

The same IP address with different netmasks on the same hardware
interface? The mind boggles. How does one handle broadcasts?

> The only one good reason for an SMTP server to bother about IP addresses at
> all is a quick check for mail loops, i.e. a check at the moment of opening
> TCP connection to send a message whether your peer is yourself.
> Bothering about network masks just doesn't have any valid grounds.

The issue is not MTA loop detection.

Postfix uses the local netmask info to distinguish between local
and remote networks. At the discretion of the sysadmin, systems on
local subnets can be granted different rights than random systems
on the Internet.

If Linux insists on breaking SIOCGIFCONF then so be it, even though
it works perfectly well on any non-Linux system that I could lay
my hands on.

	Wietse
