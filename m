Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbRHGSMt>; Tue, 7 Aug 2001 14:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269250AbRHGSMa>; Tue, 7 Aug 2001 14:12:30 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:17675 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269254AbRHGSMS>; Tue, 7 Aug 2001 14:12:18 -0400
Message-ID: <3B7030B3.9F2E8E67@zip.com.au>
Date: Tue, 07 Aug 2001 11:17:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben LaHaise <bcrl@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.31.0108070920440.31117-100000@cesium.transmeta.com> <Pine.LNX.4.33.0108071245250.30280-100000@touchme.toronto.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben LaHaise wrote:
> 
> On Tue, 7 Aug 2001, Linus Torvalds wrote:
> 
> > Try pre4.
> 
> It's similarly awful (what did you expect -- there are no meaningful
> changes between the two!).  io throughput to a 12 disk array is humming
> along at a whopping 40MB/s (can do 80) that's very spotty and jerky,
> mostly being driven by syncs.  vmscan gets delayed occasionally, and small
> interactive program loading varies from not to long (3s) to way too long
> (> 30s).

Ben, are you using software RAID?

The throughput problems which Mike Black has been seeing with
ext3 seem to be specific to an interaction with software RAID5
and possibly highmem.  I've never been able to reproduce them.
