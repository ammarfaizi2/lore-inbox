Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSIETml>; Thu, 5 Sep 2002 15:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSIETml>; Thu, 5 Sep 2002 15:42:41 -0400
Received: from maild.telia.com ([194.22.190.101]:25296 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S318184AbSIETmk>;
	Thu, 5 Sep 2002 15:42:40 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Suparna Bhattacharya <suparna@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
References: <20020905183117.GA22592@suse.de>
	<Pine.LNX.4.33.0209051136090.1307-100000@penguin.transmeta.com>
	<20020905183809.GA23195@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Sep 2002 21:47:08 +0200
In-Reply-To: <20020905183809.GA23195@suse.de>
Message-ID: <m2ofbcz0ar.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> And yes, this is 100% identical to the earlier bio code (I forget what
> revisions, and that was prior to BK I think).

It changed in 2.5.5-pre1:

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.11)
	Remove nr_sectors from bio_end_io end I/O callback. It was a relic
	from when completion was potentially called more than once to indicate
	partial end I/O. These days bio->bi_end_io is _only_ called when I/O
	has completed on the entire bio.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
