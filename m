Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316979AbSFFO2o>; Thu, 6 Jun 2002 10:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316981AbSFFO2n>; Thu, 6 Jun 2002 10:28:43 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:47736 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S316979AbSFFO2m>; Thu, 6 Jun 2002 10:28:42 -0400
Date: Thu, 6 Jun 2002 10:23:34 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: promise PDC20267 onboard supermicro P3TDDE
Message-ID: <20020606102334.E7291@coredump.electro-mechanical.com>
In-Reply-To: <20020605132018.A4803@coredump.electro-mechanical.com> <1023302356.2443.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Removing the hdd from the controller and it boots just fine.  I tried a
> > Quantum fireball lct10 05 and a seagate st34311a with the same results.
> > 
> > The bios on the pdc controller is v1.31
> 
> When 2.4.19pre10-ac2 appears please try that. I've merged a couple of
> small fixes from Promise (not all the ones they want sorting - some of
> it is a bit hairy so I'll let Andre do that 8))

[root@test:/] cat /proc/partitions 
major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse
running use aveq

  33     0    5001412 hde 25414 381073 3251824 177230 0 0 0 0 2 306060 -131520
  33     1      48163 hde1 0 0 0 0 0 0 0 0 0 0 0
  33     2    3004155 hde2 0 0 0 0 0 0 0 0 0 0 0
  33     3    1092420 hde3 0 0 0 0 0 0 0 0 0 0 0
  33     4          1 hde4 0 0 0 0 0 0 0 0 0 0 0
  33     5     393561 hde5 0 0 0 0 0 0 0 0 0 0 0
  33     6     265041 hde6 0 0 0 0 0 0 0 0 0 0 0
  33     7     192748 hde7 0 0 0 0 0 0 0 0 0 0 0
   3     0    5001412 hda 2 3 16 30 0 0 0 0 -1 308750 -308750
   3     1    4988151 hda1 0 0 0 0 0 0 0 0 0 0 0
[root@test:/] uname -a
Linux corp84 2.4.19-pre10-ac2 #2 SMP Thu Jun 6 10:20:02 EDT 2002 i686 unknown
[root@test:/] 

Looks like it works for me...  I haven't heavily used hde yet.  HD[AE] are
quantum fireballlct10 05
