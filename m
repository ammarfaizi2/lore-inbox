Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282654AbRLRNEg>; Tue, 18 Dec 2001 08:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282540AbRLRNE1>; Tue, 18 Dec 2001 08:04:27 -0500
Received: from pat.uio.no ([129.240.130.16]:62921 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281916AbRLRNEH>;
	Tue, 18 Dec 2001 08:04:07 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: war <war@starband.net>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Limits broken in 2.4.x kernel.
In-Reply-To: <3C1E5A88.57F5A68A@starband.net> <3C1E5A88.57F5A68A@starband.net>
	<shspu5dv3w4.fsf@charged.uio.no> <3C1E86BD.43EAB279@zip.com.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Dec 2001 14:03:48 +0100
In-Reply-To: <3C1E86BD.43EAB279@zip.com.au>
Message-ID: <shs3d28ade3.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     > reparent_to_init() needs to decrement current->user's processes
     > count, and increment root's.  I'll do a patch.

Please just convert 'set_user()' into a non-static routine. Calling
set_user(0, 1) would do precisely what you want, and the same thing
could then be used for kmod.
There's no real reason for having several different local hacks that
all do the same thing kicking around the place.

Cheers,
  Trond
