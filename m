Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315251AbSEaNA6>; Fri, 31 May 2002 09:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSEaNA5>; Fri, 31 May 2002 09:00:57 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:14555 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S315251AbSEaNA4>; Fri, 31 May 2002 09:00:56 -0400
Date: Fri, 31 May 2002 15:00:56 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: do_mmap
Message-ID: <Pine.GSO.4.05.10205311456070.10633-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,

what about the do_mmap/do_mmap_pgoff implementation?
reurn-type: _unsigned_ long	(which should be ok cause we've to return
				 an adress if len == 0)
on error: -ERR_*

and the checks in various places are really strange. - well some
places check for:
	o != NULL
	o > -1024UL
	o ...

guess this nedds some cleanup.

is it possible to have 0 as a valid address? - if not, this should
be the return on errors.

any comments?

	tm

-- 
in some way i do, and in some way i don't.

