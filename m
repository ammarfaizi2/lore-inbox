Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUJWQoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUJWQoC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUJWQoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:44:02 -0400
Received: from colin2.muc.de ([193.149.48.15]:50948 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261233AbUJWQnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:43:53 -0400
Date: 23 Oct 2004 18:43:52 +0200
Date: Sat, 23 Oct 2004 18:43:52 +0200
From: Andi Kleen <ak@muc.de>
To: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org,
       Sergei Haller <Sergei.Haller@math.uni-giessen.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, discuss@x86-64.org
Subject: Re: lost memory on a 4GB amd64
Message-ID: <20041023164352.GA52982@muc.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de> <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de> <Pine.LNX.4.58.0410231137450.3885@pluto.physik.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410231137450.3885@pluto.physik.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ed to discuss@x86-64.org for future reference. If you find
this message in google and you have the same problem, talk
to your BIOS vendor, not to your Linux vendor]

On Sat, Oct 23, 2004 at 12:02:10PM +0200, Andreas Klein wrote:
> - Tyan S2885 pre-production model with a 1.01 pre-release bios
> 6 mb ram (4x512mb, 4x1gb)
> The machine is running SuSE Linux Enterprise Server 8 (32bit).
> We use this machine as our primary mail-server without problems for over a 
> year.
> 
> - Now we ordered 45 Tyan S2885 and 4 S2875S board.
> Both board do not run stable with more than 2GB ram usable.
> 4GB will only be recognized if the MTRR setting is set to Continuous and 
> the Adjust Memory setting is set to Auto.
> If the bios is configured this way and two 1gb ram modules are installed 
> for each CPU on the 2885, the machine will not even load and unpack a 
> SLES 9 kernel. Memtest sees 0-2GB mem usable and 4-6GB unusable (complains 
> about each memory address).
> If all four modules are installed for CPU0, then memtest seems to work 
> without problems (0-2GB, 4-6GB), but SLES9 will crash during boot-up.
> If all four modules are installed for CPU1, then memtest seems to work 
> without problems too. SLES 9 will run a few minutes before a crash.
> I will try to install SLES 8 (32bit) on the new boxes to see if it runs 
> stable. If yes, there is something broken in the 2.6 kernels for amd64, if 
> not, the pre-production bios is better that the final ones.

It all sounds very much like a BIOS problem. I doubt 2.4 will
run stable on this setup - if memtest86 doesn't like the memory, Linux 
won't like it neither. All I can recommend is to talk to Tyan or
live with the lost memory. 

-Andi

