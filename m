Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQJ0Ncw>; Fri, 27 Oct 2000 09:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbQJ0Ncm>; Fri, 27 Oct 2000 09:32:42 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:55537 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129029AbQJ0Nch>; Fri, 27 Oct 2000 09:32:37 -0400
Date: Fri, 27 Oct 2000 11:32:06 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: mauelshagen@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: LVM snapshotting broken?
In-Reply-To: <20001027004404.A1282@athlon.random>
Message-ID: <Pine.LNX.4.21.0010271131020.25174-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, Andrea Arcangeli wrote:

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

Have you checked if the CONTENT of the snapshot is indeed
the right LV and not the other one?

(I get the same "success" messages as what you cut'n'pasted
above, but find that the wrong LV has been snapshotted when
I look at the actual snapshot)

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
