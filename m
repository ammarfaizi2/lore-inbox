Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281266AbRKPKGy>; Fri, 16 Nov 2001 05:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281265AbRKPKGp>; Fri, 16 Nov 2001 05:06:45 -0500
Received: from pop.gmx.net ([213.165.64.20]:7675 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S281266AbRKPKGi>;
	Fri, 16 Nov 2001 05:06:38 -0500
Message-ID: <3BF4E528.491CC24A@gmx.at>
Date: Fri, 16 Nov 2001 11:06:32 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: hardware raid (adaptec 1200A)?
In-Reply-To: <x88g07fn63s.fsf@adglinux1.hns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nbecker@fred.net wrote:
> 
> I'm setting up a new machine with a pair of IDE drives connected to
> adaptec 1200A controller.  I defined a RAID-0 array using the adaptec
> bios, but linux doesn't see it as a single drive.  It just sees two
> drive, hde and hdg (each at their physical sizes).  Any hints?

I think the adaptec 1200A is just another low-cost
not-quite-hardware-raid controller. As far as I have heared it is based
on Highpoint-Tech's HPT370. There is raid-0 support implemented in the
kernel.

be sure to enable CONFIG_BLK_DEV_ATARAID_HPT=y

The volumes should show up as /dev/ataraid/d[0-9]p[0-9] (major
blockdevice number 114).

bye,
Wilfried


-- 
Terorists crashed an airplane into the server room, have to remove
/bin/laden. (rm -rf /bin/laden)
