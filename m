Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280788AbRKBS7I>; Fri, 2 Nov 2001 13:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280781AbRKBS6A>; Fri, 2 Nov 2001 13:58:00 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:51592 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280795AbRKBS4Z>; Fri, 2 Nov 2001 13:56:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Fri, 2 Nov 2001 19:57:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ben Smith <ben@google.com>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <20011102181005Z16039-4784+415@humbolt.nl.linux.org> <15330.60050.705170.566887@abasin.nj.nec.com>
In-Reply-To: <15330.60050.705170.566887@abasin.nj.nec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011102185618Z16039-4784+435@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 2, 2001 07:48 pm, Sven Heinicke wrote:
>  > Not freeing the memory is expected and normal.  The previously-mlocked file 
>  > data remains cached in that memory, and even though it's not free, it's 
>  > 'easily freeable' so there's no smoking gun there.  The reason the memory is 
>  > freed on umount is, there's no possibility that that file data can be 
>  > referenced again and it makes sense to free it up immediately.
> 
> That cool and all, but how to I free up the memory w/o umounting the
> partition?

You don't, that's the mm's job.  It tries to do it at the last minute, when
it's sure the memory is needed for something more important.

> Also, I just tried 2.4.14-pre7.  It acted the same way as 2.4.13 does,
> requiring the reset key to continue.

--
Daniel
