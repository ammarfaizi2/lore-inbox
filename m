Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbSLEVTf>; Thu, 5 Dec 2002 16:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbSLEVSt>; Thu, 5 Dec 2002 16:18:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13791 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267475AbSLEVRe>;
	Thu, 5 Dec 2002 16:17:34 -0500
Date: Thu, 05 Dec 2002 13:22:13 -0800 (PST)
Message-Id: <20021205.132213.111260405.davem@redhat.com>
To: pavel@suse.cz
Cc: ak@suse.de, linux-kernel@vger.kernel.org, hubicka@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021205212120.GA1386@elf.ucw.cz>
References: <20021204111947.GB309@elf.ucw.cz>
	<20021205.130614.99253893.davem@redhat.com>
	<20021205212120.GA1386@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Thu, 5 Dec 2002 22:21:20 +0100

   > How about some test where relocations come into play?
   > spec2000 is a bad example, it's just crunch code.
   
   time ./configure might be a good test...
   
Agreed.

   > Most systems spend their time running quick small executables over and
   > over, and in such cases relocation overhead shows up very strongly.
   
   Really? What workload besides configure does many small programs?
   
What do you do when you're developing code?  make, edit, ldd, ls,
grep, etc.

   Agreed for ls and cat, but I do not think it hurts for bash...
   
It does a lot of relocations in child processes, so I bet it will
matter.  'make' might be better off since it uses vfork but on the
other hand it does have quite sizable data structures.

