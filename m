Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316993AbSFWIDr>; Sun, 23 Jun 2002 04:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSFWIDr>; Sun, 23 Jun 2002 04:03:47 -0400
Received: from spruce.woods.net ([166.70.175.33]:25784 "EHLO a.smtp.woods.net")
	by vger.kernel.org with ESMTP id <S316993AbSFWIDq>;
	Sun, 23 Jun 2002 04:03:46 -0400
Date: Sun, 23 Jun 2002 01:55:28 -0600 (MDT)
From: "Christopher E. Brown" <cbrown@woods.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, <mgross@unix-os.sc.intel.com>,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of
 spindles gets large
In-Reply-To: <3D157C7C.4080007@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0206230145000.30350-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Dave Hansen wrote:

> William Lee Irwin III wrote:
>  > On Sun, Jun 23, 2002 at 12:29:23AM -0700, Dave Hansen wrote:
>  >> Yep, 2 independent busses per quad.  That's a _lot_ of busses
>  >> when you have an 8 or 16 quad system.  (I wonder who has one of
>  >> those... ;) Almost all of the server-type boxes that we play with
>  >>  have multiple PCI busses.  Even my old dual-PPro has 2.
>  >
>  > I thought I saw 3 PCI and 1 ISA per-quad., but maybe that's the
>  > "independent" bit coming into play.
>  >
> Hmmmm.  Maybe there is another one for the onboard devices.  I thought
> that there were 8 slots and 4 per bus.  I could
> be wrong.  BTW, the ISA slot is EISA and as far as I can tell is only
> used for the MDC.


Do you mean independent in that there are 2 sets of 4 slots each
detected as a seperate PCI bus, or independent in that each set of 4
had *direct* access to the cpu side, and *does not* access via a
PCI:PCI bridge?



I have stacks of PPro/PII/Xeon boards around, but 9 out of 10 have
chianed buses.  Even the old PPro x 6 (Avion 6600/ALR 6x6/Unisys
HR/HS6000) had 2 PCI buses, however the second BUS hung off of a
PCI:PCI bridge.


-- 
I route, therefore you are.

