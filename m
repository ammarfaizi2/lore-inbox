Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261881AbRFEM5g>; Tue, 5 Jun 2001 08:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262468AbRFEM50>; Tue, 5 Jun 2001 08:57:26 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:44039 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261881AbRFEM5H>; Tue, 5 Jun 2001 08:57:07 -0400
Date: Wed, 6 Jun 2001 00:57:03 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
Message-ID: <20010606005703.A23758@metastasis.f00f.org>
In-Reply-To: <13942.991696607@redhat.com> <Pine.LNX.4.21.0106051105110.1078-100000@godzilla.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106051105110.1078-100000@godzilla.axis.se>; from bjorn.wesen@axis.com on Tue, Jun 05, 2001 at 11:17:48AM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 11:17:48AM +0200, Bjorn Wesen wrote:

    In the erase case though, yes there should be a flush. However
    during the 1-2 seconds it takes to erase a sector, you can with
    very high certainity guarantee that the direct-mapped unified 8
    kB cache on the CRIS is flushed from any flash references at
    all.. I mean, it's one-way as\sociative, during 1-2 seconds it
    executes potentially 200 million instructions. So we haven't
    really bothered to think about the problem..
    
    For other CPU's it might be more dangerous, although I don't hold
    my breath.. 1-2 seconds is a long time when talking about L1
    caches.

I don't know about the CRIS (never heard of it, what is it?), but on
an Athlon when benchmarking stuff, I could still see L1 cache hits
from data that was 15 seconds old under certain work-loads (obviously
not gcc!). Does anyone know how old something may exisit in cache
before being written back to RAM?

Even though you potentially execute millions of instructions, they
are often the same ones over and over when the machine is near idle.



  --cw
