Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280084AbRKXVDi>; Sat, 24 Nov 2001 16:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280110AbRKXVD1>; Sat, 24 Nov 2001 16:03:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39540 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280084AbRKXVDK>; Sat, 24 Nov 2001 16:03:10 -0500
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Mike Eldridge <diz@cafes.net>,
        Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex.com>
	<002801c1740f$7372f650$1300a8c0@marcelo>
	<20011123171157.Q21290@mail.cafes.net>
	<20011124031625.T2682@mea-ext.zmailer.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Nov 2001 13:43:59 -0700
In-Reply-To: <20011124031625.T2682@mea-ext.zmailer.org>
Message-ID: <m1n11bzypc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio <matti.aarnio@zmailer.org> writes:

> The 2.5 series may change the underlying block-device layer so that
> it can handle larger block devices than 2TB - the 64 bit machines can
> handle them, of course, but 32-bit i386 is a bit limited...

Definitely.  Right now the page cache on x86 has a limit (per file) of
2^32 * PAGE_SIZE == 2^32 * 2^12 = 2^44 = 16TB.  And I doubt that will
change.  x86 will be going 64bit in the next 2-3 years, at which point
I don't see it paying to push 32bit code into the larger data sizes.
Especially when we our limit is still 2 orders of magnitude larger
then the largest disk manufactured today.

Now the file size limit on x86 can be increased a little by increasing
the internal PAGE_SIZE for the page cache but that will only give us a
bit or two which really isn't significant.

Eric

