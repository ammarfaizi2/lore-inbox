Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbTHLNNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbTHLNNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:13:10 -0400
Received: from pwmail.procempa.com.br ([200.248.222.108]:60088 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S269321AbTHLNNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:13:08 -0400
Date: Tue, 12 Aug 2003 10:12:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: maney@pobox.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
In-Reply-To: <20030812035803.GA17921@furrr.two14.net>
Message-ID: <Pine.LNX.4.44.0308121011100.3386-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Aug 2003, Martin Maney wrote:

> The recipie is simple: cp a large file across filesystems.  All looks
> well (md5sums match, etc), but the file is all still present in memory. 
> But if you then unmount the destination filesystem to invalidate the
> buffers, after mounting the file data will have changed.  I'm pretty
> certain that I have observed the same effect without the mass
> invalidation of umount in a couple of cases, but I haven't replicated
> that.
> 
> In all cases I have investigated, the corruption seems to take the form
> of four bytes of garbage at the beginning of a block; two small scripts
> have been observed with 4 NULLs prepended and the last four characters
> truncated.  In another case I found a block of over 100 bytes (I got
> tired of wading through it after a while) in the same form - four bytes
> were inserted into the corrupted file, pushing the data back.  In
> hindsight I wish I had investigated that case further; as it is, I'm
> not positive the dislocation was at a disk block boundary.

Martin, 

Can you tell me exactly how can I try to reproduce the problem you're 
seeing? 

With just cp and unmount you can see the corruption? 

