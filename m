Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275504AbRIZTKC>; Wed, 26 Sep 2001 15:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275508AbRIZTJx>; Wed, 26 Sep 2001 15:09:53 -0400
Received: from freeside.toyota.com ([63.87.74.7]:59151 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S275504AbRIZTJl>; Wed, 26 Sep 2001 15:09:41 -0400
Message-ID: <3BB22807.FE63AD89@lexus.com>
Date: Wed, 26 Sep 2001 12:09:59 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Pirk <orion@deathcon.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IP aliasing/Virtual IP's in 2.2.19 or 2.4.10
In-Reply-To: <Pine.LNX.4.21.0109261152370.7017-100000@mail.pirk.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Pirk wrote:

> This much I have found so far...
> In /usr/src/linux-2.2.16/.config :
> CONFIG_IP_MASQUERADE=y
> CONFIG_IP_MASQUERADE_ICMP=y
> CONFIG_IP_MASQUERADE_MOD=y
> CONFIG_IP_MASQUERADE_IPAUTOFW=m
> CONFIG_IP_MASQUERADE_IPPORTFW=m
> CONFIG_IP_MASQUERADE_MFW=m
>
> In /usr/src/linux-2.2.19/.config
> no CONFIG_IP_MASQUERADE lines at all....
>
> Would it be save to add them to a 2.2.19 or 2.4.10 .config file?

bad idea -

>
> Is aliasing/masquerading enabled by default in kernel versions
> above 2.2.19?

I think it's a default feature in 2.4.x since I don't
see a config file option for it and it works fine on
all my boxen -

Let's check the docs:

Ah, here it is - and it matches my experience -

/usr/src/linux/Documentation/networking/alias.txt:
-----------------------------------------------------------------------------
IP-Aliasing:
============

IP-aliases are additional IP-adresses/masks hooked up to a base
interface by adding a colon and a string when running ifconfig.
This string is usually numeric, but this is not a must.

IP-Aliases are avail if CONFIG_INET (`standard' IPv4 networking)
is configured in the kernel.


o Alias creation.
  Alias creation is done by 'magic' interface naming: eg. to create a
  200.1.1.1 alias for eth0 ...

    # ifconfig eth0:0 200.1.1.1  etc,etc....
                   ~~ -> request alias #0 creation (if not yet exists) for eth0

    The corresponding route is also set up by this command.
    Please note: The route always points to the base interface.



