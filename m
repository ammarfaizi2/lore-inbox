Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSFRXe6>; Tue, 18 Jun 2002 19:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317674AbSFRXe5>; Tue, 18 Jun 2002 19:34:57 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:64350 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317673AbSFRXez>; Tue, 18 Jun 2002 19:34:55 -0400
Message-Id: <200206182334.BAA17271@post.webmailer.de>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: 2.5.22 ide disk hang on boot
Date: Wed, 19 Jun 2002 03:32:52 +0200
X-Mailer: KMail [version 1.3.2]
References: <200206172142.XAA19452@post.webmailer.de> <3D0ED3AC.6090801@evision-ventures.com>
In-Reply-To: <3D0ED3AC.6090801@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 June 2002 08:31, you wrote:

> I assume that the system in question isn't:
>
> 1. Isn't setting up the drive in BIOS for DMA operation?
Don't know. The BIOS setup does not have a config option for 
this. 'hdparm -d /dev/hda' says it's not using DMA usually.
Compiling the kernel with or without 'Generic PCI bus-master
DMA support' did not change the problem.

> 2. Isn't showring the hda: hda1.... partition layout?
The strange thing is that the primary partition table 
appears to be read proberly, but not the extended one at
the beginning of hda3, i.e. it is showing 

 p1 p2 p3 <hda: status error:

at the place where I usually get

 p1 p2 p3 < p5 p6 p7 p8 p9 p10 >

If the drive could not be read at all, it would not show the
first three entries either.

> As one can see from the above the problem is caused by PIO
> read getting worser. I know the problem and am working on it.
ok.

> As a band plase apply patch -p1 -R < ide-clean-92.diff.
As I wanted to say in the original mail: I tried that but
was too lazy to clean up the rejects. Fortunately, it's not
urgent for me, so I can just wait for the next release.
Just tell me if you want me to try your fix.

	Arnd <><
