Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278403AbRJZLsI>; Fri, 26 Oct 2001 07:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278437AbRJZLr7>; Fri, 26 Oct 2001 07:47:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3155 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278403AbRJZLro>; Fri, 26 Oct 2001 07:47:44 -0400
Date: Fri, 26 Oct 2001 13:48:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marvin Justice <Mjustice@boxxtech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre5-aa1 O_DIRECT drastic HIGHMEM performance hit
Message-ID: <20011026134819.D30905@athlon.random>
In-Reply-To: <3B6867E6CB09B24385A73719A50C7C9A01797E@athena.boxxtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3B6867E6CB09B24385A73719A50C7C9A01797E@athena.boxxtech.com>; from Mjustice@boxxtech.com on Thu, Oct 25, 2001 at 11:57:08AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 11:57:08AM -0500, Marvin Justice wrote:
> Are we stuck with a low mem configuration or are there workarounds that
> would allow us to stick with the initial 2GB of RAM and still get ~200
> MB/sec.

the problem you seen isn't specific to O_DIRECT. This should solve your
problem (not just for O_DIRECT):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/people/axboe/patches/2.4.13-pre4/block-highmem-all-17.bz2

It's a long time that I want to include the anti-bounce bits, but I am
still looking into the vm. The uglier part is that I suspect we'll also
need to make a 2G bounce option for some hardware combination. I hope
I'm wrong :).

Andrea
