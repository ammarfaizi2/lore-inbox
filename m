Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSHJS5i>; Sat, 10 Aug 2002 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHJS5i>; Sat, 10 Aug 2002 14:57:38 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:2575 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317217AbSHJS5i>; Sat, 10 Aug 2002 14:57:38 -0400
Date: Sat, 10 Aug 2002 20:01:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Message-ID: <20020810200116.A15236@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208101134510.2197-100000@home.transmeta.com> <3D556101.8080006@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D556101.8080006@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Aug 10, 2002 at 02:52:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 02:52:49PM -0400, Jeff Garzik wrote:
> While working on a race-free rewrite of cp/mv/rm (suggested by Al), I 
> did overall-time benchmarks on read+write versus sendfile/stat versus 
> mmap/stat, and found that pretty much the fastest way under Linux 2.2, 
> 2.4, and solaris was read+write of PAGE_SIZE, or PAGE_SIZE*2 chunks. 
> [obviously, 2.2 and solaris didn't do sendfile test]

Solaris 9 (and Solaris 8 with a certain patch) support Linux-style
sendfile().  Linux 2.5 on the other hand doesn't support sendfile to
files anymore..

