Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRDWVQv>; Mon, 23 Apr 2001 17:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132072AbRDWVQm>; Mon, 23 Apr 2001 17:16:42 -0400
Received: from t2.redhat.com ([199.183.24.243]:26360 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132056AbRDWVQY>; Mon, 23 Apr 2001 17:16:24 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21_heb2.09.0104232359390.2200-100000@matan.home> 
In-Reply-To: <Pine.LNX.4.21_heb2.09.0104232359390.2200-100000@matan.home> 
To: Matan Ziv-Av <matan@svgalib.org>
Cc: Russell King <rmk@arm.linux.org.uk>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Apr 2001 22:16:05 +0100
Message-ID: <2835.988060565@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


matan@svgalib.org said:
>  This is known at compile time, right? Would it not be better to
> replace the printk with #error ? Why do I need to boot the bad kernel
> to find out that it does not work, when it is known when compiling? 

It's known at compile time, but not at preprocessing time, so it can't be 
done with #error. If you can come up with a way of doing it at compile time 
such that:

 1. It's _guaranteed_ to work when the compiler does align the members 
	of the structure as we desire.
 2. It gives a message sufficiently informative that it prevents further
	such reports getting to l-k.

... then I agree, it would be better to do it at compile time. If not, the 
runtime check is the best we can do.

We really ought to have learned by now that we shouldn't be relying on the 
observed behaviour of this week's compiler in this particular phase of the 
moon.

--
dwmw2


