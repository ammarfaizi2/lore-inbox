Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318954AbSH1Uhb>; Wed, 28 Aug 2002 16:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318957AbSH1Uhb>; Wed, 28 Aug 2002 16:37:31 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:8930 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318954AbSH1Uh2>; Wed, 28 Aug 2002 16:37:28 -0400
Date: Wed, 28 Aug 2002 22:39:39 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020828223939.C816@brodo.de>
References: <Pine.LNX.4.33.0208281246560.4507-100000@penguin.transmeta.com> <1030566353.7290.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <1030566353.7290.71.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 28, 2002 at 09:25:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 09:25:53PM +0100, Alan Cox wrote:
> On Wed, 2002-08-28 at 20:49, Linus Torvalds wrote:
> That argument ultimately boils down to "should the /proc interface to
> cpufreq" be a seperate module to the core cpu_freq code called by kernel
> policy engines like ACPI. The answer is obviously "yes" - /proc is just
> one of the policy engines.

So, what do all of you think of the following implementation?

#1 The "policy modules" (/proc-interface, kernel-based frequency selector,
...) determine the target CPU frequency.

#2 This is then passed to the cpufreq core. There it is validated, 
loops_per_jiffy and other values  are adjusted.

#3 Then the cpufreq driver is called to actually set the CPU frequency.


#3 is absolutely ready, #2 in parts (the "policy module" interface is
missing, and the /proc-interface needs to be removed), and #1 is TBD.

Comments?

	Dominik
