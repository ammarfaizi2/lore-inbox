Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTE0V4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTE0V4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:56:35 -0400
Received: from pop.gmx.de ([213.165.64.20]:30260 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264218AbTE0V4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:56:33 -0400
Message-ID: <3ED3E224.1000402@gmx.net>
Date: Wed, 28 May 2003 00:09:40 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Carl Spalletta <cspalletta@yahoo.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Dan Carpenter <d_carpenter@sbcglobal.net>
Subject: Re: inventing the wheel?
References: <20030527180546.15656.qmail@web41501.mail.yahoo.com>
In-Reply-To: <20030527180546.15656.qmail@web41501.mail.yahoo.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl Spalletta wrote:
> I was interested in finding a tool that would tell me all the paths
> through the kernel leading to some particular function, for example in
> the case of do_mmap_pgoff:
> 
> do_mmap_pgoff do_mmap2 old_mmap old_mmap_i386
> do_mmap_pgoff do_mmap2 sys_mmap2
> do_mmap_pgoff do_mmap aio_setup_ring ioctx_alloc sys_io_setup
> do_mmap_pgoff do_mmap elf_map load_elf_binary
> ...
> 
> I submitted a tool ('fscope') to do this but no one has picked up
> on the discussion. So I am wondering if there isn't already some
> existing and better way to accomplish the same thing.
> 
> Could somebody tell me please, what is that way?
> 
> I know you can do a backtrace w/ gdb but that begs the question
> how are you going to sure you have found every path?

It seems everybody is busy trying Linus' sparse, so maybe it was
overlooked. Right now, it seems we have a few new tools to play with,
which were not available at the time of 2.4-test.

(Alphabetic order)
-Checker (Stanford people)
-Fscope (Carl Spalletta)
-Smatch (Dan Carpenter)
-Sparse (Linus Torvalds)

Now we only need one additional tool to *prove* correctness of the
kernel ;-)

-an automatic race finder

Liberal use of these tools should result in the most stable kernel ever.


Regards,
Carl-Daniel

