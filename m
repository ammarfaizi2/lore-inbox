Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271692AbRIGK75>; Fri, 7 Sep 2001 06:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271693AbRIGK7s>; Fri, 7 Sep 2001 06:59:48 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:28166 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S271692AbRIGK7m>; Fri, 7 Sep 2001 06:59:42 -0400
Date: Fri, 7 Sep 2001 09:52:38 +0100 (BST)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Wietse Venema <wietse@porcupine.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip
 alias
In-Reply-To: <20010906172316.E0B74BC06C@spike.porcupine.org>
Message-ID: <Pine.LNX.4.33.0109070942500.19950-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Wietse Venema wrote:

> If an MTA receives a delivery request for user@[ip.address] then
> the MTA has to decide if it is the final destination. This is
> required by the SMTP RFC.

Would it not suffice, in the common case, to check if the
local address that the SMTP connection was accepted on is
the same as the IP address in the email address?

As I see it, it breaks only for multihomed relays or weird
configurations, (with values of "breaks" close to "incurs
an extra SMTP transaction").

You could even maintain a cache of IPs that SMTP connections
had been accepted on.

Matthew.

