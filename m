Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275505AbRIZTSC>; Wed, 26 Sep 2001 15:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275514AbRIZTRw>; Wed, 26 Sep 2001 15:17:52 -0400
Received: from leg-64-133-146-200-RIA.sprinthome.com ([64.133.146.200]:63757
	"EHLO mail.pirk.com") by vger.kernel.org with ESMTP
	id <S275505AbRIZTRe>; Wed, 26 Sep 2001 15:17:34 -0400
Date: Wed, 26 Sep 2001 12:17:57 -0700 (PDT)
From: Steve Pirk <orion@deathcon.com>
To: J Sloan <jjs@toyota.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IP aliasing/Virtual IP's in 2.2.19 or 2.4.10
In-Reply-To: <3BB22807.FE63AD89@lexus.com>
Message-ID: <Pine.LNX.4.21.0109261215270.7017-100000@mail.pirk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes sense now... The version I am having trouble with
is 2.2.19. I think I will grab 2.4.4 and try that...

Thanks for all the help!

Steve
--
On Wed, 26 Sep 2001, J Sloan wrote:

  JS> Steve Pirk wrote:
  JS> 
  JS> > This much I have found so far...
  JS> > In /usr/src/linux-2.2.16/.config :
  JS> > CONFIG_IP_MASQUERADE=y
  JS> >
  JS> > In /usr/src/linux-2.2.19/.config
  JS> > no CONFIG_IP_MASQUERADE lines at all....
  JS> >
  JS> > Would it be save to add them to a 2.2.19 or 2.4.10 .config file?
  JS> 
  JS> bad idea -
agreed :-)

  JS> 
  JS> >
  JS> > Is aliasing/masquerading enabled by default in kernel versions
  JS> > above 2.2.19?
  JS> 
  JS> I think it's a default feature in 2.4.x since I don't
  JS> see a config file option for it and it works fine on
  JS> all my boxen -
  JS> 
  JS> Let's check the docs:
  JS> 

I know... I should have checked the 2.4.x docs. 

  JS> Ah, here it is - and it matches my experience -
  JS> 
  JS> /usr/src/linux/Documentation/networking/alias.txt:
  JS> -----------------------------------------------------------------------------
  JS> IP-Aliasing:
  JS> ============
  JS> 
  JS> IP-aliases are additional IP-adresses/masks hooked up to a base
  JS> interface by adding a colon and a string when running ifconfig.
  JS> This string is usually numeric, but this is not a must.
  JS> 
  JS> IP-Aliases are avail if CONFIG_INET (`standard' IPv4 networking)
  JS> is configured in the kernel.
  JS> 
  JS> 
  JS> o Alias creation.
  JS>   Alias creation is done by 'magic' interface naming: eg. to create a
  JS>   200.1.1.1 alias for eth0 ...
  JS> 
  JS>     # ifconfig eth0:0 200.1.1.1  etc,etc....
  JS>                    ~~ -> request alias #0 creation (if not yet exists) for eth0
  JS> 
  JS>     The corresponding route is also set up by this command.
  JS>     Please note: The route always points to the base interface.

-- 
Steve Pirk
orion@deathcon.com . deathcon.com . pirk.com . webops.com . t2servers.com 

