Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311280AbSCQDYt>; Sat, 16 Mar 2002 22:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311277AbSCQDYj>; Sat, 16 Mar 2002 22:24:39 -0500
Received: from host194.steeleye.com ([216.33.1.194]:31247 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S311275AbSCQDYf>; Sat, 16 Mar 2002 22:24:35 -0500
Message-Id: <200203170324.g2H3OMI02667@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dave Jones <davej@suse.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, mochel@odsl.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.6] support for NCR voyager 
In-Reply-To: Message from Dave Jones <davej@suse.de> 
   of "Thu, 14 Mar 2002 15:11:18 GMT." <20020314151118.A11178@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 22:24:21 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de said:
>   I just took a quick look at your work on splitting this stuff up,
> and I
>   think it's definitly heading in the right direction. As to
> integrating this,
>   I think it's probably best to get Patrick Mochel's other related
> work
>   included first. See what he's done so far at..
>    http://kernel.org/pub/linux/kernel/people/mochel/patches/
> patch-linux-v2.5.6-pm1.bz2
>   His patch and yours touch various files for more or less the same
> reason.

>   Patrick still has some bits to finish off here, but combined the two
> patchsets
>   will bring some much needed sanity to various parts of arch/i386/  


I just finished the combination of the two:

http://www.hansenpartnership.com/voyager/files/split-combine-2.5.6.diff
http://www.hansenpartnership.com/voyager/files/split-combine-2.5.6.BK

Also added the voyager patches

http://www.hansenpartnership.com/voyager/files/voyager-split-combine-2.5.6.diff
http://www.hansenpartnership.com/voyager/files/voyager-split-combine-2.5.6.BK

I've checked that the voyager additions will combine and boot.  There seems to 
be some problem with missing pci functions which prevent a standard SMP 
compile.  I think it has to do with a missing entry in the Makefile in 
drivers/pci for hotplug.c.  I think Patrick probably needs to look at this.

James


