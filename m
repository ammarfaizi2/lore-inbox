Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277803AbRJIP7m>; Tue, 9 Oct 2001 11:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277802AbRJIP7a>; Tue, 9 Oct 2001 11:59:30 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:7296 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S277798AbRJIP7Q>;
	Tue, 9 Oct 2001 11:59:16 -0400
Date: Tue, 09 Oct 2001 08:56:30 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Race between init_idle and reschedule_idle
Message-ID: <1890410975.1002617790@[10.10.1.2]>
In-Reply-To: <20011009091222.A4644@watson.ibm.com>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> martin, we experienced the same problem way back when we brought our
> Fujitsu based Numa machine up. We also experience the problem with 
> our cpu pooling and load balancing approach. I think the ksoftirq might
> have similar problems.
> We solved it in a similar fashion, through counters.
> I strongly suggest to put this code into the main track.

It's there, in both Linus' and Alan's latest trees. 

For ages, it showed up as an undiagnosable BINT error, but in 2.4.10 it 
changed to a  diagnosable panic, making it fairly easy to resolve. Not sure 
what changed this - may have been luck ;-)

M.

