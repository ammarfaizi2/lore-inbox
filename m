Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKGToe>; Tue, 7 Nov 2000 14:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbQKGToY>; Tue, 7 Nov 2000 14:44:24 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:34320 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129094AbQKGToN>;
	Tue, 7 Nov 2000 14:44:13 -0500
To: Robert Morris <rtm@amsterdam.lcs.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gigabit ethernet small-packet performance
In-Reply-To: <200011051507.eA5F7KX30823@amsterdam.lcs.mit.edu>
From: Jes Sorensen <jes@linuxcare.com>
Date: 07 Nov 2000 20:44:05 +0100
In-Reply-To: Robert Morris's message of "Sun, 05 Nov 2000 10:07:20 -0500"
Message-ID: <d3wvefin3u.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Robert" == Robert Morris <rtm@amsterdam.lcs.mit.edu> writes:

Robert> The short version is that the Intel Pro/1000 seems to be a lot
Robert> faster than the Alteon Tigon-II or the SysKonnect card for
Robert> small (60-byte) packets. The Intel card can send or receive at
Robert> least 500,000 60-byte packets per second (about 1/3 of a
Robert> gigabit/second). On the other hand, the Intel Linux driver
Robert> requires a lot of hacking to achieve that rate; with the
Robert> unmodified driver the board is about half that fast.

I can't comment on the SysKonnect hardware/driver. However as far as
the Alteon card is concerned I know there are issues with latency just
as it has a relatively high overhead for processing DMA descriptors
(as much as 5 micro seconds). The latter is definately going to hurt
you if your part of the pissing contest is about 60 byte packets. For
real data it is not as much of a problem.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
