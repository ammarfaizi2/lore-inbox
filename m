Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSEVKmj>; Wed, 22 May 2002 06:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSEVKmi>; Wed, 22 May 2002 06:42:38 -0400
Received: from 213-98-127-214.uc.nombres.ttd.es ([213.98.127.214]:64458 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S288748AbSEVKmi>;
	Wed, 22 May 2002 06:42:38 -0400
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.16 IDE 68
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
	<3CEB475B.1040601@evision-ventures.com>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 22 May 2002 12:48:15 +0200
Message-ID: <m2it5gfogg.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "martin" == Martin Dalecki <dalecki@evision-ventures.com> writes:

martin> Wed May 22 02:56:45 CEST 2002 ide-clean-68
martin> - Make the different ATAPI device type drivers use a unified packet command
martin> structure. We have to start to push them together.

martin> This patch is rather trivial in itself, but the plentora of code duplication it
martin> is trying to fight against is making it unfortunately rather big...

Hi

atapi.c is not a module, then it don't make sense to have a
MODULE_LICENSE :(

Notice that I don't like that kind of trap:

disable IDECD
compile kernel
enable IDECD as module
compile module

your module don't work :(

And we have had already that problem with NFS, please, make that file
_always_ compiled in, or make it a real module.

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
