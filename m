Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbQJZXH7>; Thu, 26 Oct 2000 19:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129935AbQJZXHm>; Thu, 26 Oct 2000 19:07:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37394 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129453AbQJZXG5>; Thu, 26 Oct 2000 19:06:57 -0400
Date: Thu, 26 Oct 2000 21:10:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org
Subject: Re: LVM snapshotting broken?
In-Reply-To: <20001027004404.A1282@athlon.random>
Message-ID: <Pine.LNX.4.21.0010262105380.4522-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Oct 2000, Andrea Arcangeli wrote:

> On Thu, Oct 26, 2000 at 06:34:48PM -0200, Rik van Riel wrote:
> > On Thu, 26 Oct 2000, Rik van Riel wrote:
> > 
> > > it looks like the LVM snapshotting in 2.4 doesn't allow you
> > > to create snapshots from anything else than the _first_ LV
> > > in the VG...
> > 
> > OK, I reproduced it in 2.2 as well ... ;(
> 
> Which 2.2.x? LVM isn't supported in 2.2.18pre17 or any other previous version.
> 
> For some irrelevant reason I always test snapshotting on a LV with minor
> number > 1 and the kernel side definitely works with 2.2.18pre17aa1:
> 
> laser:/home/andrea # ls -l /dev/vg1/lv*
> brw-r-----   1 root     root      58,   0 Oct 27  2000 /dev/vg1/lv0
> brw-r-----   1 root     root      58,   1 Oct 27  2000 /dev/vg1/lv1
> laser:/home/andrea # lvcreate -s -n lv1-snap /dev/vg1/lv1 -L 400M
> lvcreate -- INFO: using default snapshot chunk size of 64 KB
> lvcreate -- doing automatic backup of "vg1"
> lvcreate -- logical volume "/dev/vg1/lv1-snap" successfully created
> 
> laser:/home/andrea # lvremove -f /dev/vg1/lv1-snap 
> lvremove -- doing automatic backup of volume group "vg1"
> lvremove -- logical volume "/dev/vg1/lv1-snap" successfully removed
> 
> laser:/home/andrea # 

With LVM from 2.2.18aa kernels (I dont exactly remember which one)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
