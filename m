Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265408AbRF0VUD>; Wed, 27 Jun 2001 17:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbRF0VTn>; Wed, 27 Jun 2001 17:19:43 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:58633 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265408AbRF0VTl>;
	Wed, 27 Jun 2001 17:19:41 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106272119.f5RLJcP325544@saturn.cs.uml.edu>
Subject: Re: [PATCH] User chroot
To: hpa@transmeta.com (H. Peter Anvin)
Date: Wed, 27 Jun 2001 17:19:38 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl
In-Reply-To: <3B3A4A09.F7D8D5BA@transmeta.com> from "H. Peter Anvin" at Jun 27, 2001 02:03:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> "Albert D. Cahalan" wrote:

>> BTW, it is way wrong that /dev/zero should be needed at all.
>> Such use is undocumented ("man zero", "man mmap") anyway, and
>> AFAIK one should use mmap() with MAP_ANON instead. Not that
>> the documentation on MAP_ANON is any good either, but at least
>> the mere existence of the flag is mentioned.
>
> RTFM(POSIX).

No manual entry for RTFM in section POSIX

Seriously:

1. both features ought to be documented in the man pages
   (I did submit a man page too, back in 1996)

2. it is slow and nasty to open /dev/zero for getting memory
