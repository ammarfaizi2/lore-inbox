Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318900AbSG1Dsp>; Sat, 27 Jul 2002 23:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318901AbSG1Dsp>; Sat, 27 Jul 2002 23:48:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1028 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318900AbSG1Dso>;
	Sat, 27 Jul 2002 23:48:44 -0400
Message-ID: <3D436A44.8080505@mandrakesoft.com>
Date: Sat, 27 Jul 2002 23:51:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, torvalds@transmeta.com
Subject: Re: [PATCH] automatic initcalls
References: <20020728033359.7B2A2444C@lists.samba.org>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> The more I play with these magic approaches, the more I prefer an
> explicit "Must be done after this" and "must be done before this":
> otherwise we're going to need to keep adding new levels as we discover
> something that doesn't fit in the magic 7.

I've always preferred a system where one simply lists dependencies [as 
you describe above], and some program actually does the hard work of 
chasing down all the initcall dependency checking and ordering.

Linus has traditionally poo-pooed this so I haven't put any work towards 
it... but I still think it's a good idea, and something we will 
eventually need as our system grows more complex.  If someone stood up 
and did the work, it should be pretty easy to generate a human-readable 
list of dependencies so we can check the ordering and make sure it's 
getting things right.

I wonder if there is some nifty ld feature I'm missing, that could do 
this for us...

	Jeff



