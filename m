Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283644AbRK3MsL>; Fri, 30 Nov 2001 07:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283647AbRK3MsB>; Fri, 30 Nov 2001 07:48:01 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:40460 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S283644AbRK3Mrt>;
	Fri, 30 Nov 2001 07:47:49 -0500
Date: Fri, 30 Nov 2001 05:41:26 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: "David C. Hansen" <haveblue@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
Message-ID: <20011130054126.A18099@hq2>
In-Reply-To: <3C057410.3090201@us.ibm.com> <Pine.GSO.4.21.0111300444180.13367-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0111300444180.13367-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 04:57:28AM -0500, Alexander Viro wrote:
> In other words, patch is completely bogus.  BKL removal may be a good
> idea, but you really need to audit the code.  Which requires at least
> some understanding of the things you are doing.  There _are_ races
> and they need to be dealt with.  But blind BKL removal doesn't fix any
> and breaks quite a few places where the code was actually correct.

People seem to believe that BKL is worse than added spin-locks, but I
very much doubt this is always true.

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
