Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRATTdt>; Sat, 20 Jan 2001 14:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRATTdj>; Sat, 20 Jan 2001 14:33:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:43353 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129991AbRATTd1>; Sat, 20 Jan 2001 14:33:27 -0500
Date: Sat, 20 Jan 2001 20:30:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: mingo@elte.hu, torvalds@transmeta.com, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010120203023.A5274@athlon.random>
In-Reply-To: <20010120192320.J8717@athlon.random> <200101201905.WAA05165@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101201905.WAA05165@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Jan 20, 2001 at 10:05:45PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 10:05:45PM +0300, kuznet@ms2.inr.ac.ru wrote:
> It makes. One small packet is allowed to fly, not depending on packets_out.

So this mean if I do:

	write(100000*MSS)
	write(1)
	write(1)

2.4 can send 100000 packet with MSS large payload plus two packets with a
payload of 1 byte even if during the two write(1) the previous packets were
still out (not acknowledged yet). Classical nagle would send 100000 packet with
MSS large payload plus 1 packet with a two bytes payload in the same
scenario.

Andre 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
