Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWHYRFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWHYRFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422691AbWHYRFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:05:21 -0400
Received: from web83113.mail.mud.yahoo.com ([216.252.101.42]:28751 "HELO
	web83113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422684AbWHYRFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:05:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5LD5bu3WSPqSu/kTCv6aHqBQqu0MTcOF3hnfaZBNbwnc7Fe64vTt/m3ojft7y7U0IiDGeqrVbIvwnmV/KmgtGEAM0NGYMZmEGDuzRwUeL1161SlcmavOen4Pg5dKrbwAXX9pL+J0dSr6q8mhDHuCb1hqZovVT5wv589aI1hiSqc=  ;
Message-ID: <20060825170513.60108.qmail@web83113.mail.mud.yahoo.com>
Date: Fri, 25 Aug 2006 10:05:13 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Generic Disk Driver in Linux
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, satinder.jeet@gmail.com
In-Reply-To: <44EECF16.6060602@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Helge Hafting <helge.hafting@aitel.hist.no> wrote:

> Aleksey Gorelov wrote:
> >> From: linux-kernel-owner@vger.kernel.org 
> >> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> >>     
> >>> I was curious that can we develop a generic disk driver that could
> >>> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
> >>>       
> >> ide_generic
> >> sd_mod
> >>
> >> All there, what more do you want?
> >>     
> >
> > Unfortunately, not _all_. DMRAID does not support all fake raids yet. Moreover, there is
> usually
> > some gap for bleeding edge hw support.
> >   
> Nobody will want to use bleeding edge hardware with an int13 driver,
> because the performance will necessarily be much worse than using more
> moderate hardware with the generic IDE driver.
If some one wants Linux server - I totally agree. I would probably even avoid relying purely on
generic IDE and instead use chipset specific variant or libata.
But if someone wants to access already installed & working other OS stuff - that's a different
story. Bad performance is still better than no support at all.

> 
> Int13 for new hardware makes no sense to me.  The same goes for
> fake raids - linux will usually be able to see the disks as single
> disks, and you can then use them as such with a plain
> software raid on top.  The fakeraid functionality is not needed,
> it has no performance edge precicely because it is fake.
> 
> If fakeraid support is necessary to read some existing filesystem,
> then implement support in md or dmraid or even as a userspace
> filesystem.  Either choice will perform better, and also be
> easier to do than making a working and stable int13 driver.
> 
> 
> Helge Hafting
> 

You are right here. I only see the possibility of int13 driver as some 'backup' plan for HW that
not yet have enough support via native drivers, or if someone wants occasional access and does not
want to upgrade to latest kernels for some reason.

