Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbRIDVHx>; Tue, 4 Sep 2001 17:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269257AbRIDVHo>; Tue, 4 Sep 2001 17:07:44 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:33553 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S269254AbRIDVHd>;
	Tue, 4 Sep 2001 17:07:33 -0400
Date: Tue, 4 Sep 2001 15:07:50 -0600
From: Val Henson <val@nmt.edu>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Lost TCP retransmission timer
Message-ID: <20010904150750.D22301@boardwalk>
In-Reply-To: <20010830161139.A18224@boardwalk> <200109011436.SAA18432@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109011436.SAA18432@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Sep 01, 2001 at 06:36:35PM +0400
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 06:36:35PM +0400, kuznet@ms2.inr.ac.ru wrote:
> 
> Lots? I see only about 24K of data transmitted in both your samples.

:) Okay, "lots" is relative.  If you only telnet in and exit right
away, you won't see it.

> Actually, the problem is more or less clear from your /proc/net/tcp.
> You use some funny device or netfilter plugin, which leak memory.
> You can look into 7th column of /proc/net/tcp to estimate amount of leaked
> buffers. When it reaches ~15, connection stalls. Seems, it raises
> monotonically, so that it looks like all the buffers leak.
> 
> What is output device?

ncr885e, which I believe I am the de facto maintainer of... Dan Cox
wrote it while he was working for Synergy Microsystems.  When he quit,
I was hired to replace him.  Anyone else using this driver?  I have a
patch for it that fixes some other things (currently only in the
LinuxPPC tree) but not this.

Thanks for the help, I think this is my problem to fix now.

-VAL
