Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318851AbSHLWWJ>; Mon, 12 Aug 2002 18:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318852AbSHLWWJ>; Mon, 12 Aug 2002 18:22:09 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:29690 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318851AbSHLWWI>; Mon, 12 Aug 2002 18:22:08 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15704.13792.150136.849896@wombat.chubb.wattle.id.au>
Date: Tue, 13 Aug 2002 08:25:36 +1000
To: Christoph Hellwig <hch@infradead.org>
Cc: Phil Auld <pauld@egenera.com>, viro@math.psu.edu,
       marcelo@connectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 revert block_llseek behavior to standard
In-Reply-To: <266483518@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph>   What's the behaviour of other unix
Christoph> systems when seeking beyond the end of block devices? 

The seek succeeds; 

On a disc-like device, attempts to write at that offset return -1 EFBIG;
the first attempt to read at that offset returns 0; subequent ones
return -1 and ENXIO.

After the seek, lseek(fd, 0, SEEK_CURRENT) returns the (after end of
file) current offset.

At least for the ones I've been able to test on (UNIXWare, Solaris).


--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
