Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292402AbSBUOzM>; Thu, 21 Feb 2002 09:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292404AbSBUOzE>; Thu, 21 Feb 2002 09:55:04 -0500
Received: from ns.suse.de ([213.95.15.193]:43536 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292402AbSBUOy4>;
	Thu, 21 Feb 2002 09:54:56 -0500
Date: Thu, 21 Feb 2002 15:54:47 +0100
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christer Weinigel <wingel@acolyte.hack.org>, wingel@nano-system.com,
        jgarzik@mandrakesoft.com, roy@karlsbakk.net,
        linux-kernel@vger.kernel.org
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
Message-ID: <20020221155447.C5583@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christer Weinigel <wingel@acolyte.hack.org>, wingel@nano-system.com,
	jgarzik@mandrakesoft.com, roy@karlsbakk.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16dtPo-0006vd-00@the-village.bc.nu> <Pine.LNX.4.44.0202211619320.11932-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0202211619320.11932-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Thu, Feb 21, 2002 at 04:27:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 04:27:34PM +0200, Zwane Mwaikambo wrote:
 > Thanks Alan and Jeff for the input, i'll cleanup this stuff. Out of 
 > interest, do we normally take in patches for specialised embedded boxes? I 
 > see the AMD Elan stuff got in but that only touched one area and was easy 
 > to integrate. I presume they'd get accepted if the code was broken up into 
 > seperate modules instead of being overly specialised. For example, the 
 > CRIS stuff in the Etrax tree (developer.axis.com).

 It seems lately there has been a surge of interest in getting
 niche x86 clones included in mainline (Voyager, numaq, Elan, etc).
 I forget who it was who suggested it, but the idea came up of
 using a similar approach to arm's subarchitecture support for x86.

 The downsides would probably be a lot of code duplication,
 The upside would be hiding away specialised code from the 99% of
 people who don't need to see it.  The Voyager patch for example
 was ~150kb iirc, and was imo still quite intrusive even after
 a first round of suggestions. Putting it into arch/x86-32/voyager/
 would allow those that do care about it to do whatever they deem
 necessary without inflicting dozens of #ifdefs and the likes
 on the majority.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
