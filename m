Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132737AbREHPIY>; Tue, 8 May 2001 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbREHPIO>; Tue, 8 May 2001 11:08:14 -0400
Received: from unthought.net ([212.97.129.24]:25751 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S132825AbREHPH5>;
	Tue, 8 May 2001 11:07:57 -0400
Date: Tue, 8 May 2001 17:07:55 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Peter Waltenberg <peterw@dascom.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID question
Message-ID: <20010508170755.A32160@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Peter Waltenberg <peterw@dascom.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <988925908.1280.42.camel@agate> <XFMail.20010508124825.peterw@dascom.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <XFMail.20010508124825.peterw@dascom.com.au>; from peterw@dascom.com.au on Tue, May 08, 2001 at 12:48:25PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2001 at 12:48:25PM +1000, Peter Waltenberg wrote:
> We have a RAID 5 system thats had 2 of 6 disks in the RAID go into thermal
> shutdown. (Air-con failure).
> 
> The disks are functional, but the RAID won't restart because the superblock
> timestamps on those two disks are now out of step with the rest of the array and
> there aren't enough "good" disks to reconstruct the array.
> 
> We know there was very little activity when this happened.
> 
> Does anyone out there know of a way to hack the superblocks on the "bad" disks
> to force them to appear to be O.K. so that the RAID will restart. 

As documented in the HOWTO (http://unthought.net/Software-RAID.HOWTO), you should
re-run mkraid after making dead sure that your raidtab still corrosponds to the
RAID on your disks (it usually does unless someone screwed it up).

Run fsck on the RAID after mkraid.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
