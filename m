Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSHOSXq>; Thu, 15 Aug 2002 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSHOSXq>; Thu, 15 Aug 2002 14:23:46 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:2042 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317345AbSHOSXq>; Thu, 15 Aug 2002 14:23:46 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 15 Aug 2002 12:25:56 -0600
To: henrique <henrique@cyclades.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
Message-ID: <20020815182556.GV9642@clusterfs.com>
Mail-Followup-To: henrique <henrique@cyclades.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200208151514.51462.henrique@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208151514.51462.henrique@cyclades.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2002  15:14 +0000, henrique wrote:
> Hello !!!
> 
> I am trying to use a program (ipsec newhostkey) that uses the random device 
> provided by the linux-kernel. In a x86 machine the program works fine but 
> when I tried to run the program in a PPC machine it doesn't work.
> 
> Looking carefully I have discovered that the problem is in the driver 
> random.c. When the program tries to read any amount of data it locks and 
> never returns. It happens because the variable  "random_state->entropy_count" 
> is always zero, that is, any random number is generated at all !!!??.
> 
> Does anyone know anything about this problem ? Any sort of help is very 
> welcomed.

Maybe the PPC keyboard/mouse drivers do not add randomness?  You should
also get randomness from disk I/O.  If your PPC system is diskless,
mouseless, and keyboardless, there is also a patch for 2.4 which allows
you to get randomness from network card interrupts, which is good enough
for all but the most incredibly paranoid people.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

