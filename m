Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312413AbSC3JGc>; Sat, 30 Mar 2002 04:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSC3JGW>; Sat, 30 Mar 2002 04:06:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42001 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312413AbSC3JGM>; Sat, 30 Mar 2002 04:06:12 -0500
Date: Sat, 30 Mar 2002 09:06:02 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5: bad config
Message-ID: <20020330090602.B23576@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.21.0203291842530.6417-100000@freak.distro.conectiva> <3CA502A0.54547786@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 11:11:12AM +1100, Eyal Lebedinsky wrote:
> In drivers/mtd/maps/Config.in CONFIG_ARM is used in the condition, so
> maybe a better patch will be to do the same here? I leave this to the
> experts.

I have a patch for this.

> -dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_ARCH_SA1100 $CONFIG_PCMCIA
> +if [ "$CONFIG_ARCH_SA1100" = "y" ]; then
> +	dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_PCMCIA
> +fi

It's basically to wrap it in an CONFIG_ARM and leave the SA1100 dependency.
Why?  There are other ARM PCMCIA drivers, and rather have a mass of if
statements, I'd rather see dep_*

I'll dig out the patch later today.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

