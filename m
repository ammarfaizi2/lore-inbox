Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135720AbRAZSMY>; Fri, 26 Jan 2001 13:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135373AbRAZSMP>; Fri, 26 Jan 2001 13:12:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14884 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130615AbRAZSMM>; Fri, 26 Jan 2001 13:12:12 -0500
Date: Fri, 26 Jan 2001 19:12:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Simon Kirby <sim@stormix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECN
Message-ID: <20010126191238.D24774@athlon.random>
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <20010126154447.L3849@marowsky-bree.de> <20010126160342.B7096@pcep-jamie.cern.ch> <14961.37986.469902.496834@pizda.ninka.net> <20010126120556.A13417@stormix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010126120556.A13417@stormix.com>; from sim@stormix.com on Fri, Jan 26, 2001 at 12:05:56PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 12:05:56PM -0500, Simon Kirby wrote:
> Hmm... Just wondering: what does TCP then do when it receives this ECN
> notification?  Try harder, try less?  Or does it get a specific packet

It will act in the same way if it the packet was dropped (but the packet wasn't
dropped). That is quite obviously correct behaviour. The RFC also mentions that
different congestion control treatment would be unfair with the non-ECN capable
TCP connections (but obviously non-ECN TCP connections are just penalized with
the current algorithm so such argument doesn't make much sense to me, said that
the standard congestion control looks sane choice and it also avoids a mess in
the TCP code internals).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
