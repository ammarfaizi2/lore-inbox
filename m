Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSHJTAW>; Sat, 10 Aug 2002 15:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSHJTAV>; Sat, 10 Aug 2002 15:00:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59151 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317253AbSHJTAV>;
	Sat, 10 Aug 2002 15:00:21 -0400
Message-ID: <3D5563A5.2050007@mandrakesoft.com>
Date: Sat, 10 Aug 2002 15:04:05 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <Pine.LNX.4.44.0208101134510.2197-100000@home.transmeta.com> <3D556101.8080006@mandrakesoft.com> <20020810200116.A15236@infradead.org>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Aug 10, 2002 at 02:52:49PM -0400, Jeff Garzik wrote:
> 
>>While working on a race-free rewrite of cp/mv/rm (suggested by Al), I 
>>did overall-time benchmarks on read+write versus sendfile/stat versus 
>>mmap/stat, and found that pretty much the fastest way under Linux 2.2, 
>>2.4, and solaris was read+write of PAGE_SIZE, or PAGE_SIZE*2 chunks. 
>>[obviously, 2.2 and solaris didn't do sendfile test]
> 
> 
> Solaris 9 (and Solaris 8 with a certain patch) support Linux-style
> sendfile().  Linux 2.5 on the other hand doesn't support sendfile to
> files anymore..



Really?  Bummer :)  That was a useful hack for some cases...

