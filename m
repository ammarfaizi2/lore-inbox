Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSA2X1Z>; Tue, 29 Jan 2002 18:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbSA2XZt>; Tue, 29 Jan 2002 18:25:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4874 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287115AbSA2XUA>; Tue, 29 Jan 2002 18:20:00 -0500
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
To: riel@conectiva.com.br (Rik van Riel)
Date: Tue, 29 Jan 2002 23:32:08 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0201292059440.32617-100000@imladris.surriel.com> from "Rik van Riel" at Jan 29, 2002 09:01:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VhjU-0005Vb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We can let oracle shared memory segments use 4 MB pages,
> but still use the normal page cache code to look up the
> pages.

That has some potential big wins beyond oracle. Some of the big number
crunching algorithms also benefit heavily from 4Mb pages even when you
try and minimise tlb misses.

Just remember to read the ppro/early pII errata when starting - there are
some page invalidation funnies. If I remember rightly we have to kill MCE
support on PPro if we do 4Mb pages that may overlap 4K ones
