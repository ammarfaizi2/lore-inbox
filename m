Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBUBbE>; Tue, 20 Feb 2001 20:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131322AbRBUBay>; Tue, 20 Feb 2001 20:30:54 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:31171 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129249AbRBUBam>;
	Tue, 20 Feb 2001 20:30:42 -0500
Message-ID: <3A931A3C.8050000@lycosmail.com>
Date: Tue, 20 Feb 2001 20:30:36 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac6 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: patch: loop-5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

Please excuse this possibly stupid q. I don't know as much about kernel 
hacking as I would like to.

I noticed that you are rewriting the loop block device to be a block 
remapper (yes, I had noticed this before, the q just never occurred to 
me before); does this imply that the native block size of the loop file 
fs must be the same size as the underlying fs? exemplia gratia, ext2 fs 
w/ block size 1024, iso image block size 2048; or ext2 block size 1024, 
reiserfs image block size 512 (I'm assuming this is possible, but don't 
know for sure. of course on reiserfs the likely best size is 4096 to 
match page size, since tails are packed anyway); or perhaps a more 
useful/common example than the previous: iso block size 2048, ext2 block 
size 1024 (most common block size, right??).

I admit that I gave one, maybe two more examples than necessary. the 
idea of the first two was to cover both possibilities, i.e. loop larger 
than base, and loop smaller than base. The third was merely to ward off 
the possiblity that the 3rd was and impossible configuration, and to 
reduce flames from various people who consider something this 
"elementary" to be "obvious", either in utility or specification.

