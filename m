Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbRBNU3g>; Wed, 14 Feb 2001 15:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130170AbRBNU30>; Wed, 14 Feb 2001 15:29:26 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49681 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129374AbRBNU3I>; Wed, 14 Feb 2001 15:29:08 -0500
Subject: Re: Samba performance / zero-copy network I/O
To: glamb@lcis.dyndns.org (Gord R. Lamb)
Date: Wed, 14 Feb 2001 20:29:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.32.0102141452210.27843-100000@localhost.localdomain> from "Gord R. Lamb" at Feb 14, 2001 03:14:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T8Ya-0005wb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When reading the profiler results, the largest consuming kernel (calls?)
> are file_read_actor and csum_partial_copy_generic, by a longshot (about
> 70% and 20% respectively).
> 
> Presumably, the csum_partial_copy_generic should be eliminated (or at
> least reduced) by David Miller's zerocopy patch, right?  Or am I
> misunderstanding this completely? :)

To an extent, providing you are using the samba sendfile() patches. SMB cant
make great use of zero copy file I/O due to the fact its not really designed
so much as mutated over time and isnt oriented for speed

