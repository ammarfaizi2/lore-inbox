Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKUSat>; Tue, 21 Nov 2000 13:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQKUSaj>; Tue, 21 Nov 2000 13:30:39 -0500
Received: from unthought.net ([212.97.129.24]:23443 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S129231AbQKUSaZ>;
	Tue, 21 Nov 2000 13:30:25 -0500
Date: Tue, 21 Nov 2000 19:00:23 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 & Performances
Message-ID: <20001121190023.R4635@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Roberto Fichera <kernel@tekno-soft.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20001121174403.00d3e450@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <4.3.2.7.2.20001121174403.00d3e450@mail.tekno-soft.it>; from kernel@tekno-soft.it on Tue, Nov 21, 2000 at 05:58:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 05:58:58PM +0100, Roberto Fichera wrote:
> Hi All,
> 
> I need to know if there are some differences, in performances, between
> a ext2 filesystem in a 10Gb partition and another that reside in a 130Gb,
> each one have 4Kb block size.
> 
> I'm configuring a Compaq ML350 2x800PIII, 1Gb RAM, 5x36Gb UWS3 RAID 5
> with Smart Array 4300, as database SQL server. So I need to chose between a 
> single
> partition of 130Gb or multiple small partitions, depending by the performances.

Does your database *require* a filesystem ?   At least Oracle can do without,
but I don't know about others...

Usually, if you want performance, you let the database use the block device
without putting a filesystem on top of it.

You probably don't want a 130G ext2 if there is any chance that a power
surge etc. can cause the machine to reboot without umount()'ing the 
filesystem.  A fsck on a 130G filesystem is going to take a *long* time.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
