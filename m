Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbRBXHRJ>; Sat, 24 Feb 2001 02:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRBXHQt>; Sat, 24 Feb 2001 02:16:49 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:52489 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129388AbRBXHQo>; Sat, 24 Feb 2001 02:16:44 -0500
Date: Sat, 24 Feb 2001 01:16:36 -0600
To: Drew Bertola <drew@drewb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt-464c and 2.4.1
Message-ID: <20010224011636.B11263@cadcamlab.org>
In-Reply-To: <14999.15825.67045.845336@champ.drew.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <14999.15825.67045.845336@champ.drew.net>; from drew@drewb.com on Sat, Feb 24, 2001 at 04:51:29AM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Drew Bertola]
> Feb 23 20:48:24 babylon modprobe: modprobe: Can't locate module binfmt-464c

> Although I've looked through the documentation, I can't find any
> reference to binfmt-464c.

binfmt-464c is ELF -- it means your kernel came across an ELF
executable and was unable to execute it so it tried to load the ELF
binary format module.  Since you have ELF compiled into your kernel
already, this didn't work.

My guess is that you have a corrupt ELF executable on your system,
which your ELF loader refuses to load.  Every time someone tries to
execute it, your kernel will do a 'modprobe -k binfmt-464c'.

If you can't find the executable in question and just want to get the
message out of your logs, add

  alias binfmt-464c off

to your /etc/modules.conf .

Peter
