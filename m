Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279591AbRKHHcQ>; Thu, 8 Nov 2001 02:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281482AbRKHHb4>; Thu, 8 Nov 2001 02:31:56 -0500
Received: from proxy.povodiodry.cz ([212.47.5.214]:18673 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S281480AbRKHHby>;
	Thu, 8 Nov 2001 02:31:54 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Thu, 8 Nov 2001 08:31:45 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011108083145.B3094@pc11.op.pod.cz>
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com>; from Peter.Seiderer@ciselant.de on Wed, Nov 07, 2001 at 06:47:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 06:47:10PM +0100, Peter Seiderer wrote:
> Hello,
> tried today to mkfs.ext2 a partition of my disk and detected there is
> a little difference between 'login: root' and 'su -'.

[snip]

> The RLIMIT_FSIZE showed in both cases the same values:
> getrlimit(RLIMIT_FSIZE) rlim_cur: 2147483647 rlim_max: 2147483647
> 
> Can anybody point me out what went wrong? Is it a kernel limit?

  I had similar problems. The root of all evil was ulimit in bash. After
compiling bash against the new glibc and kernel headers, all was O.K.
(the bad bash was instaled in kernel-2.2 times). So check if you have the
latest versions of kernel, glibc, e2fsprogs and bash (maybe others)
recompiled.

	Cheers,
		Vita
