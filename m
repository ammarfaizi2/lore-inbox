Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291103AbSAaPUe>; Thu, 31 Jan 2002 10:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291104AbSAaPU1>; Thu, 31 Jan 2002 10:20:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291103AbSAaPUI>; Thu, 31 Jan 2002 10:20:08 -0500
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 31 Jan 2002 15:32:24 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel), velco@fadata.bg (Momchil Velikov),
        stoffel@casc.com (John Stoffel),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20020131153607.C1309@athlon.random> from "Andrea Arcangeli" at Jan 31, 2002 03:36:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WJCK-0002Qi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mathematically the hashtable complexity is O(N). But probabilistically
> with the tuning we do on the hashtable size, the collisions will be
> nearly zero for most buckets for of most workloads. Despite the worst
> case is with all the pagecache and swapcache queued in a single linked
> list :).

Providing it handles the worst case. Some of the hash table inputs appear
to be user controllable so an end user can set out to get worst case 
behaviour 8(
