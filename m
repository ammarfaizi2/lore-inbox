Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSJLKxX>; Sat, 12 Oct 2002 06:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbSJLKxX>; Sat, 12 Oct 2002 06:53:23 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:23564 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262881AbSJLKxW>; Sat, 12 Oct 2002 06:53:22 -0400
From: "Helge Hafting" <helgehaf@idb.hist.no>
Date: Sat, 12 Oct 2002 12:59:28 +0200
To: linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au
Subject: 2.5.42 raid0 compile failure?
Message-ID: <20021012105928.GA10941@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried compiling 2.5.42 with gcc 2.95.4.
I use Peter Chubb's raid0 patch which
worked fine with 2.5.41

compiling, I got this:
drivers/built-in.o: In function `raid0_mergeable_bvec':
drivers/built-in.o(.text+0xa497d): undefined reference to `__umoddi3'
drivers/built-in.o: In function `raid0_make_request':
drivers/built-in.o(.text+0xa4d23): undefined reference to `__umoddi3'

These functions use the % operator with sector_t,
so I guess there is a problem with the new 64-bit sector_t.

Helge Hafting

