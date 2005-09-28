Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVI1UNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVI1UNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVI1UNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:13:32 -0400
Received: from smtpout.mac.com ([17.250.248.73]:31994 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750760AbVI1UNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:13:31 -0400
In-Reply-To: <98b62faa05092809423ac837bc@mail.gmail.com>
References: <98b62faa050928001275d28771@mail.gmail.com> <200509280757.j8S7vmjB023730@turing-police.cc.vt.edu> <98b62faa050928015677d7253b@mail.gmail.com> <200509280923.j8S9Nkgq028579@turing-police.cc.vt.edu> <98b62faa05092809423ac837bc@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7F0D0031-D142-4231-A162-014137051DB1@mac.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: raw aio write guarantee
Date: Wed, 28 Sep 2005 16:13:04 -0400
To: iodophlymiaelo@gmail.com
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 28, 2005, at 12:42:50, iodophlymiaelo@gmail.com wrote:
> Erm, is the hardware problem really as great as you're implying?  
> Have you personally encountered any bad drives made by reputable  
> brands? Mostly I've only heard only of people crying wolf and then  
> realizing it was a problem with their reasoning or with the  
> assumption that fsync() actually works properly on kernel X, where  
> X doesn't even have to be that ancient a version of linux ;-)

No, I've seen several sample cases on this list of drives where the  
IDE or SCSI cache flush commands did not trigger any disk activity  
and the only way to force it out of the cache was to write several  
meg of garbage to some file.  In some cases (Like RAID cards with  
good battery backup, for example), they may ignore the flush cache  
command as it isn't really useful (although on such good cards, they   
usually haw a way to turn it off, too).

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+ 
++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


