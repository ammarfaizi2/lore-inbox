Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUJWKDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUJWKDE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUJWKDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:03:03 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26827 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S266463AbUJWKC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:02:28 -0400
Date: Sat, 23 Oct 2004 12:02:10 +0200 (CEST)
From: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>
X-X-Sender: asklein@pluto.physik.uni-wuerzburg.de
To: Andi Kleen <ak@muc.de>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org,
       Sergei Haller <Sergei.Haller@math.uni-giessen.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <20041022182446.GA77384@muc.de>
Message-ID: <Pine.LNX.4.58.0410231137450.3885@pluto.physik.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
 <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on domino1/uni-wuerzburg(Release 6.51HF561 | September
 17, 2004) at 10/23/2004 12:02:20,
	Serialize by Router on domino1/uni-wuerzburg(Release 6.51HF561 | September
 17, 2004) at 10/23/2004 12:02:23,
	Serialize complete at 10/23/2004 12:02:23
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have the same problem with 45 Tyan S2885 boards, but I have one running 
sample. The one running machine has the following configuration:

- Tyan S2885 pre-production model with a 1.01 pre-release bios
6 mb ram (4x512mb, 4x1gb)
The machine is running SuSE Linux Enterprise Server 8 (32bit).
We use this machine as our primary mail-server without problems for over a 
year.

- Now we ordered 45 Tyan S2885 and 4 S2875S board.
Both board do not run stable with more than 2GB ram usable.
4GB will only be recognized if the MTRR setting is set to Continuous and 
the Adjust Memory setting is set to Auto.
If the bios is configured this way and two 1gb ram modules are installed 
for each CPU on the 2885, the machine will not even load and unpack a 
SLES 9 kernel. Memtest sees 0-2GB mem usable and 4-6GB unusable (complains 
about each memory address).
If all four modules are installed for CPU0, then memtest seems to work 
without problems (0-2GB, 4-6GB), but SLES9 will crash during boot-up.
If all four modules are installed for CPU1, then memtest seems to work 
without problems too. SLES 9 will run a few minutes before a crash.
I will try to install SLES 8 (32bit) on the new boxes to see if it runs 
stable. If yes, there is something broken in the 2.6 kernels for amd64, if 
not, the pre-production bios is better that the final ones.

Bye,

On Fri, 22 Oct 2004, Andi Kleen wrote:

> > I've cc'ed Andi Kleen (x86_64 supremo) who might have some insights, but I'm 
> > guessing he'll say "Bios problem - tough luck". I might be wrong ;)
> 
> Is there a full boot log of the system? 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- Andreas Klein
   asklein@cip.physik.uni-wuerzburg.de
   root / webmaster @cip.physik.uni-wuerzburg.de
   root / webmaster @www.physik.uni-wuerzburg.de
_____________________________________
|                                   | 
|   Long live our gracious AMIGA!   |
|___________________________________|

