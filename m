Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUBEOjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUBEOjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:39:22 -0500
Received: from s4.uklinux.net ([80.84.72.14]:64714 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S263486AbUBEOjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:39:21 -0500
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040202194626.191cbb95.akpm@osdl.org>
	<87llnk2js9.fsf@codematters.co.uk>
	<20040203132913.6145f4e6.akpm@osdl.org>
	<87znbzg78o.fsf@codematters.co.uk> <402087B3.1080302@cyberone.com.au>
	<877jz291jm.fsf@codematters.co.uk> <87y8riifey.fsf@codematters.co.uk>
	<4021AF52.1080009@cyberone.com.au>
From: Philip Martin <philip@codematters.co.uk>
Date: Thu, 05 Feb 2004 14:27:03 +0000
In-Reply-To: <4021AF52.1080009@cyberone.com.au> (Nick Piggin's message of
 "Thu, 05 Feb 2004 13:49:54 +1100")
Message-ID: <874qu5fvpk.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

> Sorry, I mean what is it that you are timing?

It's a bit of software (Subversion) built using "make -j4".  It
consists of a little over 200 C files compiled to object code, then
linked to about a dozen shared libraries, and finally linked to create
over a dozen executables.  It uses libtool, so each compile/link
involves running a bit of shell code before runing gcc.  It lends
itself to parallel builds, on 2.4 there is little difference in the
build time using -j2, -j4, -j8.  The source code is about 16MB and the
object/library/executable about 28MB.

>>This is the profile for 2.6.2, it is very much like 2.6.1
>>
>>248.07user 118.81system 3:42.00elapsed 165%CPU (0avgtext+0avgdata 0maxresident)k
>>0inputs+0outputs (434major+3770493minor)pagefaults 0swaps
>
> If you get time, could you test the patch I sent you?

Your patch doesn't apply to plain 2.6.2.  I got 2.6.2-mm1 and it looks
like that already includes your patch, correct?  This is what I got
for 2.6.2-mm1

247.02user 118.33system 3:51.24elapsed 157%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (176major+3771994minor)pagefaults 0swaps

so it's not really an improvement on plain 2.6.2.

-- 
Philip Martin
