Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSE2Ky6>; Wed, 29 May 2002 06:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSE2Ky5>; Wed, 29 May 2002 06:54:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19679 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314835AbSE2Kyz>;
	Wed, 29 May 2002 06:54:55 -0400
Date: Wed, 29 May 2002 12:51:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] ide-tape.c must include buffer_head.h
Message-ID: <20020529105107.GM17674@suse.de>
In-Reply-To: <Pine.NEB.4.44.0205262258180.20535-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26 2002, Adrian Bunk wrote:
> Hi Christoph,
> 
> after your removal of #include <linux/buffer_head.h> from fs.h ide-tape.c
> no longer compiles:

The usage of BH_Lock is completely wrong in ide-tape! BH_Lock is a
buffer_head flag, but it's setting/clearing the bio flags. Whoever did
that 2.5 conversion messed that part up.

-- 
Jens Axboe

