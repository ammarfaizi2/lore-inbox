Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSJaNlV>; Thu, 31 Oct 2002 08:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262879AbSJaNlV>; Thu, 31 Oct 2002 08:41:21 -0500
Received: from telesol.usm.my ([161.142.10.15]:4262 "EHLO telesol.usm.my")
	by vger.kernel.org with ESMTP id <S261415AbSJaNlU>;
	Thu, 31 Oct 2002 08:41:20 -0500
Date: Thu, 31 Oct 2002 22:05:09 +0800
From: Sebastien Morand <sebastien@telesol.usm.my>
To: linux-kernel@vger.kernel.org
Subject: About mmap
Message-ID: <20021031140509.GA2296@telesol.usm.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm implementing a cache for a database file system. Using mmap I
would like to know how mmap works.

For instance if my file is open in read/write and I'm mapping in
read/write but I use only the block in write, is the kernel going to
read on the disk?

Here is a sample code:
int h = open(file, O_RDWR | O_SYNC);
void * memory =
  mmap(0, pageSize, PROT_WRITE | PROT_READ, MAP_SHARED, handle, 0);

I'm actually using the same code to get read or write block, so if I'm
using the block in write only I would like to know if this code is
correct or if I'd better change the flags according to writing or
reading access.

Sincerely,
Sebastien Morand.

NB: I'm not on the mailing list, can you put my e-mail in CC to reply
please.
