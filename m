Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317638AbSGPPBQ>; Tue, 16 Jul 2002 11:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317770AbSGPPBQ>; Tue, 16 Jul 2002 11:01:16 -0400
Received: from gate.in-addr.de ([212.8.193.158]:13317 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S317638AbSGPPBP>;
	Tue, 16 Jul 2002 11:01:15 -0400
Date: Tue, 16 Jul 2002 16:17:18 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Joerg Schilling <schilling@fokus.gmd.de>, James.Bottomley@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020716141718.GF18432@marowsky-bree.de>
References: <200207161406.g6GE6tYh021918@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200207161406.g6GE6tYh021918@burner.fokus.gmd.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-16T16:06:55,
   Joerg Schilling <schilling@fokus.gmd.de> said:

> Just a hint: the block layer is for caching blocks from disk type deveices.
> 
> -	Block device access is always going directly into the block cache.  So
> the I/O is always kernel I/O. In addition, it is async I/O - the block layer
> fires it up and may wait for it later after sending out other requests.
> 
> -	Character device access is synchronous access and may be either kernel
> or user space DMA access. In most cases, it is user space DMA access.
> 
> How try to ask your question again...

Right, and you can build one on top of the other in this fashion. I don't see
the problem.

> >That is not true. Late IDE also has this, and systems like drbd - which
> >currently uses a quite clever heuristic to deduce barriers - could also
> >utilize this input.
> How is it implemented?

drbd does an analysis of the write-patterns, look at
http://www.complang.tuwien.ac.at/reisner/drbd/publications/index.html, Philipp
has written a diploma thesis on it.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

