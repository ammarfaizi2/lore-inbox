Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSLQUDS>; Tue, 17 Dec 2002 15:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSLQUDS>; Tue, 17 Dec 2002 15:03:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29412
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267044AbSLQUDQ>; Tue, 17 Dec 2002 15:03:16 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <160470000.1040153210@flay>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
	<3DFF772E.2050107@transmeta.com>  <160470000.1040153210@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 20:51:11 +0000
Message-Id: <1040158271.20765.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 19:26, Martin J. Bligh wrote:
> >> It's not as good as a pure user-mode solution using tsc could be, but
> You can't use the TSC to do gettimeofday on boxes where they aren't 
> syncronised anyway though. That's nothing to do with vsyscalls, you just
> need a different time source (eg the legacy stuff or HPET/cyclone).

Ditto all the laptops and the like. With code provided by the kernel we
can cheat however. If we know the fastest the CPU can go (ie full speed
on spudstop/powernow etc) we can tell the tsc value at which we have to
query the kernel to get time to any given accuracy, so allowing limited
caching

Ditto by knowing the worst case drift on summit

Alan

