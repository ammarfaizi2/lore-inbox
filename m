Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132843AbRDPClQ>; Sun, 15 Apr 2001 22:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132846AbRDPClG>; Sun, 15 Apr 2001 22:41:06 -0400
Received: from geos.coastside.net ([207.213.212.4]:20619 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S132844AbRDPCk5>; Sun, 15 Apr 2001 22:40:57 -0400
Mime-Version: 1.0
Message-Id: <p05100b09b7000a8c3bc9@[207.213.214.34]>
In-Reply-To: <01041521302600.15046@tabby>
In-Reply-To: <E14oxbX-0000oM-00@sites.inka.de> <01041521302600.15046@tabby>
Date: Sun, 15 Apr 2001 19:38:06 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:23 PM -0500 2001-04-15, Jesse Pollard wrote:
> >b) wait with fsck until rebuild is fixed
>
>Depends on your definition of "fixed". The most I can see to fix is
>reduce the amount of continued update in favor of updating those blocks
>being read (by fsck or anything else). This really ought to be a runtime
>configuration option. If it is set to 0, then no automatic repair would
>be done.

The original post was referring to RAID 1; there's no repair necessary at the RAID level to give fsck the correct data. Seems to me the basic problem here is that the RAID re-sync is supposed to be throttling back to allow other activity to run, but that in the case of fsck the other activity is still slower by a large factor (compared to no RAID re-sync).

Is this a pathological case because of the way fsck does business, or does the RAID re-sync affect any disk-bound process that severely?
-- 
/Jonathan Lundell.
