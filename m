Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282299AbRKXAOS>; Fri, 23 Nov 2001 19:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282300AbRKXAN5>; Fri, 23 Nov 2001 19:13:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39073 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282299AbRKXAN4>;
	Fri, 23 Nov 2001 19:13:56 -0500
Date: Fri, 23 Nov 2001 19:13:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.0 breakage even with fix?
In-Reply-To: <A0A71547524@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0111231909421.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Petr Vandrovec wrote:

> After reboot fsck was NOT run, so it is possible that there
> might be some corruption - but I ran fsck on my non-root partition
> after boot, and it did not show any problems.

fsck -f

Filesystem _is_ marked clean, so unless you do forced fsck no checks
are done.

Moreover, attempt to work with corrupted fs can break in very interesting
ways, so unless you do fsck -f even correct kernel (be it patched 2.4.15
or something earlier than 2.4.15-pre9) will not help.

