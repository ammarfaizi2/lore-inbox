Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318649AbSHLDVf>; Sun, 11 Aug 2002 23:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSHLDVf>; Sun, 11 Aug 2002 23:21:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53772 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318649AbSHLDVf>; Sun, 11 Aug 2002 23:21:35 -0400
Date: Sun, 11 Aug 2002 20:27:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Simon Kirby <sim@netnation.com>, <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <3D572B4C.90F4AF3C@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208112023200.1518-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Aug 2002, Andrew Morton wrote:
> 
> At least that's the theory, and the testing I did yesterday
> was succesful.

Did you try Simons test-case which seemed to be just a "cat" on a floppy 

  "To demonstrate the problem reliably, I've used "strace -r cat" on a
   floppy, which is a sufficiently slow medium. :)  This is on a 2.4.19
   kernel, but 2.5 behaves similarly.")

although that may be different from the NFS issue, it is kind of
interesting: the perfect behaviour would be a steady stream of data, not
too many hickups. 

		Linus

