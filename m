Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130272AbQK2Hux>; Wed, 29 Nov 2000 02:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130439AbQK2Hun>; Wed, 29 Nov 2000 02:50:43 -0500
Received: from cs.columbia.edu ([128.59.16.20]:5813 "EHLO cs.columbia.edu")
        by vger.kernel.org with ESMTP id <S130272AbQK2Hud>;
        Wed, 29 Nov 2000 02:50:33 -0500
Date: Tue, 28 Nov 2000 23:20:05 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <3A24AB70.3E9C1B1F@haque.net>
Message-ID: <Pine.LNX.4.21.0011282316490.29520-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Mohammad A. Haque wrote:

> [mhaque@viper mhaque]$ df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/hda3             12737128   9988400   2101712  83% /
> /dev/hda2                46668     15106     29153  35% /boot
> /dev/hdd1             44327416  26319188  15756484  63% /home2
> none                   8388608     11944   8376664   1% /dev/shm

No, you misunderstood me. df is always going to say 1k-blocks, but that
doesn't mean that the filesystem's allocation unit is actually 1k.

Try doing a tune2fs -l on the device holding the filesystem and grep for
"Block size". Although... looking at the numbers above, it's almost
certainly 4k.

> Yes, exactly 4096 nulls.

That's what I thought... thanks.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
