Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292356AbSBUMcx>; Thu, 21 Feb 2002 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292357AbSBUMcd>; Thu, 21 Feb 2002 07:32:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61447 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292356AbSBUMcT>;
	Thu, 21 Feb 2002 07:32:19 -0500
Message-ID: <3C74E8D1.D74BAD5@mandrakesoft.com>
Date: Thu, 21 Feb 2002 07:32:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.21.0202211312510.2318-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Thu, 21 Feb 2002, Jeff Garzik wrote:
> > FWIW a much better transition path is very close to what your tool does,
> > and is a suggestion made by mec (kbuild maintainer) near the end of the
> > recent flamewar:  convert config.in files one at a time, like we did the
> > old makefiles.
> 
> That's possible, as soon as the menu information is added, both formats
> contain the same information, so a program with two parsers can handle
> both simultaneously.

yep

> > That would imply a rewrite of make [old]config, and an updating of make
> > menu|xconfig, to handle the new format...
> 
> I think we should just dump the old tools and implement a single config
> library, which exports an interface to access the config information.

I do not think we can -avoid- dumping scripts/Configure[1], replacing
the existing tools.  In that respect I agree with Eric and the others. 
So your proposition makes sense.  But the configuration language can and
should be migrated, IMO.

	Jeff



[1] Sure you could code a replacement parser in bash shell script.  But
that's just wanking, like a Georgia Tech professor of mine:  he
implemented a visual Towers of Hanoi solver in vi macros.  We all
thought it was cool but ultimately CS wanking of no real value :)

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
