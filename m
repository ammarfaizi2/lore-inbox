Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWFHDtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWFHDtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 23:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWFHDtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 23:49:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:61310 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932490AbWFHDtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 23:49:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s8U7pzq3ettlv03+l5crjWDN5I/91Gj3yn1mOWCT80f+/C4yFvr/fOZE1aJVfppTPldkDmC+hDVLN/6ONKSylEaa0L9TGTgXe5e5NW//WyJ8EmFeF2fLH2+D/G2J9P+LY8mPWHVnIE0v+yPt4XdopUEGF4B7BkrM1DDBgtjBi7c=
Message-ID: <5bdc1c8b0606072049t78eccec1w8b3b1d4024ede7ee@mail.gmail.com>
Date: Wed, 7 Jun 2006 20:49:09 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc6-rt1
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Deepak Saxena" <dsaxena@plexity.net>
In-Reply-To: <20060607211455.GA6132@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060607211455.GA6132@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
   Since the Gentoo Pro-Audio overlay guys were so quick to get
2.6.17-rc6-rt1 into an ebuild I downloaded and built the kernel this
evening using that method.

1) The kernel did boot on my AMD64 machine.

2) gdm segfaulted so I couldn't run X.

3) Basic functionality was available in a console window.

   I expect the gdm problem is on my end. Maybe it's a VGA driver
issue or something like that? I'll check that out tomorrow.

   Anyway, it does boot so that's a start.

Cheers,
Mark

On 6/7/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from
> the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> the biggest change was the port to 2.6.17-rc6, and the moving to John's
> latest and greatest GTOD queue. Most of the porting was done by Thomas
> Gleixner (thanks Thomas!). We also picked up the freshest genirq queue
> from -mm and the freshest PI-futex patchset. There are also lots of ARM
> fixups and enhancements from Deepak Saxena and Daniel Walker.
>
> if we accidentally dropped some fix in the process then please complain.
> x86 and x86_64 build and boot, but some initial rough edges are to be
> expected. Deepak, your ARM-GTOD patches are included but not tested yet.
>
> to build a 2.6.17-rc6-rt1 tree, the following patches should be applied:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17-rc6.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.17-rc6-rt1
>
>         Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
