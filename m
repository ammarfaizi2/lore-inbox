Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129442AbRBHCo4>; Wed, 7 Feb 2001 21:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129317AbRBHCoq>; Wed, 7 Feb 2001 21:44:46 -0500
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:29868 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129279AbRBHCom>; Wed, 7 Feb 2001 21:44:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14978.2306.408780.856419@pcg.localdomain>
Date: Thu, 8 Feb 2001 03:48:34 +0100
From: Pascal Brisset <Pascal.Brisset@wanadoo.fr>
To: Billy Harvey <Billy.Harvey@thrillseeker.net>
Cc: linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: 2.4.1-ac5 - The loopback hang saga continues (not me ?)
In-Reply-To: <14977.61456.680691.926157@rhino.thrillseeker.net>
In-Reply-To: <Pine.LNX.4.21.0102071723090.7611-100000@winds.org>
	<14977.61456.680691.926157@rhino.thrillseeker.net>
X-Mailer: VM 6.87 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI following hints from the linux-crypto mailing-list archives, I am
using the following configuration :

linux-2.4.0
patch-int-2.4.0.3
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0/loop-1.gz
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0/loop-bdev-inc-1.gz
util-linux-2.10o
Documentation/crypto/util-linux-2.10o.patch

I setup an encrypted 2097152000 byte loopback partition and moved
800MB of data there, including a 90MB file.

My only problems are:
- rc.d/init.d/S01reboot sometimes fails to unmount partitions with
  loop files on them (this already happened with 2.2.17).
- losetup after losetup -d sometimes fails.

-- Pascal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
