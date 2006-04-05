Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWDEAm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWDEAm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWDEAm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:42:29 -0400
Received: from test-iport-3.cisco.com ([171.71.176.78]:630 "EHLO
	test-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750917AbWDEAm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:42:28 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       openib-general@openib.org, bunk@stusta.de, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mst@mellanox.co.il,
       rolandd@cisco.com
Subject: Re: [patch 11/26] IPOB: Move destructor from neigh->ops to neigh_param
X-Message-Flag: Warning: May contain useful information
References: <20060405000030.GL27049@kroah.com>
	<20060404.170720.61536177.davem@davemloft.net>
	<adar74cnajg.fsf@cisco.com>
	<20060404.171739.92845421.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 04 Apr 2006 17:42:20 -0700
In-Reply-To: <20060404.171739.92845421.davem@davemloft.net> (David S. Miller's message of "Tue, 04 Apr 2006 17:17:39 -0700 (PDT)")
Message-ID: <adamzf0n98z.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Apr 2006 00:42:22.0118 (UTC) FILETIME=[CCF62C60:01C65849]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> You were using an interface in an unintended way.

There were a lot of opportunities to suggest a better way or even just
raise the alarm when IPoIB was first being reviewed.  And I don't
remember anyone giving any guidance or insight into the neighbour
destructor design the three or four times Michael raised the issue of
the IPoIB crash and posted this patch for review....

    David> Do you know %100 for certain that moving that callback to a
    David> different location won't break anything?

Of course it's not %100 certain, but it definitely fixes a panic in
IPoIB, and the clip.c change looks "obviously correct."

If this patch is too risky for -stable, that's fine.  But let's be
clear that it _does_ fix a panic people hit in practice, and as far as
I know it doesn't break the ATM build

 - R.
