Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272253AbRIESZM>; Wed, 5 Sep 2001 14:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272256AbRIESZE>; Wed, 5 Sep 2001 14:25:04 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:11231
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S272249AbRIESYz>; Wed, 5 Sep 2001 14:24:55 -0400
Message-ID: <3B966E19.3B9B10B4@nortelnetworks.com>
Date: Wed, 05 Sep 2001 14:25:29 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Wietse Venema <wietse@porcupine.org>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <20010905170037.A6473@emma1.emma.line.org> <20010905152738.C5912BC06D@spike.porcupine.org> <20010905182033.D3926@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

> Wietse Venema and I are wondering about different Linux 2.2/2.4 and
> FreeBSD 4.4-RC behaviour when using ioctls to figure interface netmasks,
> FreeBSD gets it right, Linux 2.4.9 and 2.4.9-ac7 get it wrong, and from
> looking at the source, I think, Linux 2.2.19 gets it wrong as well.

> Looking at Linux' Kernel source, Linux 2.4.9 compares just the ifr_name,
> /usr/src/linux/net/ipv4/devinet.c, function devinet_ioctl, ll.  463 ff.
> in 2.4.9, so Linux always returns the mask for the first address, not
> the mask for the requested address. This doesn't matter as long as
> eth0:0-style aliases are configured with ifconfig, but it does matter as
> soon as ip comes into play and both addresses are assigned to eth0
> rather than eth0 and eth0:0.


I think the silence you are hearing from the lkml is a bunch of people thinking
"Oh, crap!".

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
