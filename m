Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbRFQW57>; Sun, 17 Jun 2001 18:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263127AbRFQW5u>; Sun, 17 Jun 2001 18:57:50 -0400
Received: from laurin.munich.netsurf.de ([194.64.166.1]:1173 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S263123AbRFQW5j>; Sun, 17 Jun 2001 18:57:39 -0400
Date: Mon, 18 Jun 2001 00:53:29 +0200
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a memory-related problem?
Message-ID: <20010618005329.A3704@storm.local>
Mail-Followup-To: Ronald Bultje <rbultje@ronald.bitfreak.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDEJIPDFCLGDNEHGCAJPOEFGCCAA.rbultje@ronald.bitfreak.net>
User-Agent: Mutt/1.3.18i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 02:37:03PM +0200, Ronald Bultje wrote:
> system = p-II 400 MHz, 128 MB swap, 440BX (abit p6b) mainboard
> memory is (133 MHz) SDRAM memory (running at 100 MHz)

The question is, does it configure your SDRAMs correctly?  I assume it's
on auto config, then the BIOS has to figure out what timings to use for
the RAMs by reading their SPD ROM.

Problem 1: you run PC133 memory in PC100 configuration.  Some PC133
DIMMs contain no configuration data for PC100, so they theoretically
couldn't legally be run as PC100.  They could be run using the PC133
config - not optimal, but should work.  The BIOS has to figure that out,
however.  This problem is more likely to occur if you're using no-name
RAMs instead of branded RAMs by a reputable vendor (you might not even
have fully valid config data for PC133 in that case).

Problem 2: your BIOS is broken and configures all DIMMs to the
configuration values of the first, causing at least one to run with the
wrong values, if they have different timing requirements.  Given your
problem (either DIMM works alone, two don't), this sounds like a more
possible candidate.

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
