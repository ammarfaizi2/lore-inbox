Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRJ3Rgx>; Tue, 30 Oct 2001 12:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277316AbRJ3Rgo>; Tue, 30 Oct 2001 12:36:44 -0500
Received: from s2.relay.oleane.net ([195.25.12.49]:59665 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S276361AbRJ3Rgb>; Tue, 30 Oct 2001 12:36:31 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
Date: Tue, 30 Oct 2001 18:36:23 +0100
Message-Id: <20011030173623.24069@smtp.adsl.oleane.com>
In-Reply-To: <20011030172352.16727@smtp.adsl.oleane.com>
In-Reply-To: <20011030172352.16727@smtp.adsl.oleane.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Since we can't (AFAIK) have linux use larger PTEs (in which case we
>could store a pointer to the hash PTE in the linux PTE), We could
>instead layout an array of pointer (one for each page) that would
>hold these.
>
>That way, we have a fast way to grab the real accessed and dirty
>bits, which means we no longer need to flush hash pages when getting
>those bits and have a more realistic PAGE_ACCESSED (currently, any page
>in the hash has PAGE_ACCESSED).

Obviously, an array of pointer would be horrible bloat, maybe the
layout of a parallel page table (ARM does this I think) would make
more sense. 

I don't know if it would be really an improvement however.

ben.


