Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283968AbRLAGRW>; Sat, 1 Dec 2001 01:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283947AbRLAGRL>; Sat, 1 Dec 2001 01:17:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6159 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281470AbRLAGRI>; Sat, 1 Dec 2001 01:17:08 -0500
Message-ID: <3C0875DA.A54BC89E@zip.com.au>
Date: Fri, 30 Nov 2001 22:16:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: war <war@starband.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is it normal for freezing while...
In-Reply-To: <3C085B04.50ABE0B5@starband.net> <3C0867A3.5119D2BC@zip.com.au> <3C087023.9683B8AF@starband.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war wrote:
> 
> Wow, responsiveness is wonderful with these patches.

yup.  Thanks for testing...

> Will they make it into 2.4.17, (ie: I've seen the -pre2 changelog, did
> you incorporate them into -pre2)?
> Even throughout the entire dd, it remained responsive
> (mouse/cursor/network/etc).

Well, this is a stable kernel, and the patch does adversely
affect overall throughput.

There are two changes to the elevator in that patch.  One
is a modest speedup for all workloads which, frankly, I'm
inclined to drop.   The other is the part which gives the
improved responsiveness.

Being a cautious chap, I think I'll submit that patch, with
the default setting to "off", so there is no change to default
kernel behaviour.   Then people can run `elvtune -b' to enable it.

-
