Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbUJZL35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUJZL35 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbUJZL35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:29:57 -0400
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:8936 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262224AbUJZL3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:29:53 -0400
Date: Tue, 26 Oct 2004 13:25:03 +0200 (CEST)
From: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>
X-X-Sender: asklein@pluto.physik.uni-wuerzburg.de
To: Andi Kleen <ak@muc.de>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org,
       Sergei Haller <Sergei.Haller@math.uni-giessen.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, discuss@x86-64.org
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <20041023164352.GA52982@muc.de>
Message-ID: <Pine.LNX.4.58.0410261319220.3903@pluto.physik.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
 <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de>
 <Pine.LNX.4.58.0410231137450.3885@pluto.physik.uni-wuerzburg.de>
 <20041023164352.GA52982@muc.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on domino1/uni-wuerzburg(Release 6.51HF561 | September
 17, 2004) at 10/26/2004 13:25:03,
	Serialize by Router on domino1/uni-wuerzburg(Release 6.51HF561 | September
 17, 2004) at 10/26/2004 13:29:51,
	Serialize complete at 10/26/2004 13:29:51
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

You are right. I tried now to install SLES 8 (32bit) and the system 
hangs when initialising CPU0. Our running pre-production sample was 
installed from the same CD and with exactly the same setup.
So something is really broken in the final bios or in the final board 
layout.
The only thing I haven't tried is to flash the pre-production bios on the 
final boards.

Bye,

On Sat, 23 Oct 2004, Andi Kleen wrote:

> [cc'ed to discuss@x86-64.org for future reference. If you find
> this message in google and you have the same problem, talk
> to your BIOS vendor, not to your Linux vendor]
> 
> On Sat, Oct 23, 2004 at 12:02:10PM +0200, Andreas Klein wrote:
> > - Tyan S2885 pre-production model with a 1.01 pre-release bios
> > 6 mb ram (4x512mb, 4x1gb)
> > The machine is running SuSE Linux Enterprise Server 8 (32bit).
> > We use this machine as our primary mail-server without problems for over a 
> > year.
> > 
> > - Now we ordered 45 Tyan S2885 and 4 S2875S board.
> > Both board do not run stable with more than 2GB ram usable.
> > 4GB will only be recognized if the MTRR setting is set to Continuous and 
> > the Adjust Memory setting is set to Auto.
> > If the bios is configured this way and two 1gb ram modules are installed 
> > for each CPU on the 2885, the machine will not even load and unpack a 
> > SLES 9 kernel. Memtest sees 0-2GB mem usable and 4-6GB unusable (complains 
> > about each memory address).
> > If all four modules are installed for CPU0, then memtest seems to work 
> > without problems (0-2GB, 4-6GB), but SLES9 will crash during boot-up.
> > If all four modules are installed for CPU1, then memtest seems to work 
> > without problems too. SLES 9 will run a few minutes before a crash.
> > I will try to install SLES 8 (32bit) on the new boxes to see if it runs 
> > stable. If yes, there is something broken in the 2.6 kernels for amd64, if 
> > not, the pre-production bios is better that the final ones.
> 
> It all sounds very much like a BIOS problem. I doubt 2.4 will
> run stable on this setup - if memtest86 doesn't like the memory, Linux 
> won't like it neither. All I can recommend is to talk to Tyan or
> live with the lost memory. 
> 
> -Andi
> 
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

