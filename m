Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293357AbSBYJEq>; Mon, 25 Feb 2002 04:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293358AbSBYJEg>; Mon, 25 Feb 2002 04:04:36 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:34832 "HELO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with SMTP
	id <S293357AbSBYJEV>; Mon, 25 Feb 2002 04:04:21 -0500
Date: Mon, 25 Feb 2002 10:04:19 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Cc: David Stroupe <dstroupe@keyed-upsoftware.com>
Subject: Re: Q: Interfacing to driver
Message-ID: <20020225100419.B8370@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
	David Stroupe <dstroupe@keyed-upsoftware.com>
In-Reply-To: <3C797770.3000206@keyed-upsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C797770.3000206@keyed-upsoftware.com>; from dstroupe@keyed-upsoftware.com on Sun, Feb 24, 2002 at 05:29:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have created a driver for a custom board.  This driver exports the 
> functions that I need to access from my user programs to control the 
> card.  How do I declare and call this driver function within my user 
> code so that it will call the device driver function?
> TIA

Exporting makes symbol available to other kernel modules.
You need to register char device or proc entry and define ioctl for it to
call functions you need. You may define read and write if you can define
kind of a comunication protocol.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
