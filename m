Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbREQTJT>; Thu, 17 May 2001 15:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbREQTJJ>; Thu, 17 May 2001 15:09:09 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:17671 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S261508AbREQTIv>; Thu, 17 May 2001 15:08:51 -0400
Date: Thu, 17 May 2001 12:08:45 -0700
Message-Id: <200105171908.f4HJ8jD17107@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: James Fidell <james@cloud9.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 rev 12 problems
In-Reply-To: <20010517165904.C24712@gluttony.corp.cloud9.co.uk>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001 16:59:04 +0100, James Fidell <james@cloud9.co.uk> wrote:
> I have two eepro100 interfaces in a machine, one rev 8, which works just
> fine, and another rev 12, which appears as a device when the kernel boots
> and can be configured with an IP address etc., but I can't get any data
> in or out of it.  All the other hardware looks like it's working fine and
> all my rev 8 cards work, so I'm led to ask, are there any known problems
> with eepro100 rev 12 cards under 2.2.18?

Is this a real card, or is it built-in on the motherboard?

I don't think eepro100 has got much testing with rev > 9, though it should
have worked. All eepro100 chips are supposed to be backwards compatible with
the 82557, but maybe our driver initializes some registers in a way that
upsets newer chips. Not having docs for the newer chips doesn't help, either...

Intel's own e100 driver probably works, their code does things differently if
rev >= 12 (what they call the D102 revision). Give it a spin, I guess.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
