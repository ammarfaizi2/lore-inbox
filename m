Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275061AbRJFO0C>; Sat, 6 Oct 2001 10:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275041AbRJFOZw>; Sat, 6 Oct 2001 10:25:52 -0400
Received: from [195.223.140.107] ([195.223.140.107]:58618 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274684AbRJFOZs>;
	Sat, 6 Oct 2001 10:25:48 -0400
Date: Sat, 6 Oct 2001 16:26:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: OOM-Killer in 2.4.11pre4
Message-ID: <20011006162617.A724@athlon.random>
In-Reply-To: <E15plMj-0002eK-00@mrvdom01.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E15plMj-0002eK-00@mrvdom01.schlund.de>; from linux-kernel@borntraeger.net on Sat, Oct 06, 2001 at 08:53:30AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 08:53:30AM +0200, Christian Bornträger wrote:
> I reported __alloc_pages: 0-order allocation failed errors in 2.4.10 with a 
> memory eating program. 
> 
> These errors are gone with 2.4.11pre4. The OOM-Killer works __correct__.  it 
> seems that Marcelos Patch works correct for me.

to test the oom killer you should try to run out of memory sometime.
It's not the oom killer that cured the oom faliures, it is the deadlock
prone infinite loop in the allocator that did.

Now I identified various issues that can explain the oom faliures on the
highmem boxes (I don't have any highmem box so it wasn't possible to
trigger them here, the higher memory ia32 machine that I own is my
UP desktop with 512mbyte of ram), and I will be able to verify my fixes
as soon as I can get a login on a 4/8G box. I created this project for
this purpose:

	http://www.osdlab.org/cgi-bin/eidetic.cgi?command=display&modulename=projects&on=60

After I get the login and after verifying my fixes I'll release a new
-aa that will be meant primarly to fix the allocation faliures.

Andrea
