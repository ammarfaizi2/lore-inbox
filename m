Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAKVbm>; Thu, 11 Jan 2001 16:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132957AbRAKVbc>; Thu, 11 Jan 2001 16:31:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24708 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129511AbRAKVb2>;
	Thu, 11 Jan 2001 16:31:28 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14942.9759.730641.804611@pizda.ninka.net>
Date: Thu, 11 Jan 2001 13:31:11 -0800 (PST)
To: nigel@nrg.org
Cc: andrewm@uow.edu.au, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <Pine.LNX.4.05.10101111233241.5936-100000@cosmic.nrg.org>
In-Reply-To: <200101110519.VAA02784@pizda.ninka.net>
	<Pine.LNX.4.05.10101111233241.5936-100000@cosmic.nrg.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nigel Gamble writes:
 > That's why MontaVista's kernel preemption patch uses sleeping mutex
 > locks instead of spinlocks for the long held locks.

Anyone who uses sleeping mutex locks is asking for trouble.  Priority
inversion is an issue I dearly hope we never have to deal with in the
Linux kernel, and sleeping SMP mutex locks lead to exactly this kind
of problem.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
