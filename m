Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSHATO5>; Thu, 1 Aug 2002 15:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSHATO5>; Thu, 1 Aug 2002 15:14:57 -0400
Received: from tapu.f00f.org ([66.60.186.129]:20150 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S316786AbSHATOz>;
	Thu, 1 Aug 2002 15:14:55 -0400
Date: Thu, 1 Aug 2002 12:18:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020801191823.GA24428@tapu.f00f.org>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 09:30:04AM -0700, Linus Torvalds wrote:

    A 2% error may not be a big problem for most people, of course. But it
    might be a huge problem for others. Those people would have to do their
    own re-calibration..

How about export the value via a syscall and also export an 'error'
which for now could just be set to 5% or something conservative and
refined later if necessary or cleanup on other architectures,
something like:

    /* export monotonically increasing nanoseconds since boot to
       user-space. kt_time is a relative value, it does NOT necessarily
       imply nanoseconds since boot. kt_err should be greater than
       1stdev of the error in kt_time */

    struct kern_time {
	  __u64 kt_ns;
	  __u64 kt_err;
    };




  --cw
