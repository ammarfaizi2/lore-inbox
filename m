Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281744AbRKULrn>; Wed, 21 Nov 2001 06:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281743AbRKULrd>; Wed, 21 Nov 2001 06:47:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17938 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281732AbRKULrY>;
	Wed, 21 Nov 2001 06:47:24 -0500
Date: Wed, 21 Nov 2001 12:47:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
Message-ID: <20011121124706.C9978@suse.de>
In-Reply-To: <20011121122034.B9978@suse.de> <Pine.LNX.4.33.0111211240220.4080-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111211240220.4080-100000@Appserv.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21 2001, Dave Jones wrote:
> On Wed, 21 Nov 2001, Jens Axboe wrote:
> 
> > No there is a bug there, I can confirm that mine does the same (ie
> > second athlon is not reported with correct model name)
> 
> Interesting. But they are definitly the same CPU models ?
> x86info -a info please ? (pub/people/davej on ftp.suse.com)
> 
> Could be your BIOS isn't setting up 2nd CPU name string.
> Harmless, but dumb.  If this is the case, I wonder what else
> it forgets to do.

Weee

[root@bart x86info-1.5]# ./x86info -a | grep "name string"
Processor name string: AMD Athlon(tm) MP Processor 1700+
Processor name string: AMD Athlon(tm) MP Processor 1700+
[root@bart x86info-1.5]# ./x86info -a | grep "name string"
Processor name string: AMD Athlon(tm) Processor
Processor name string: AMD Athlon(tm) Processor
[root@bart x86info-1.5]# ./x86info -a | grep "name string"
Processor name string: AMD Athlon(tm) MP Processor 1700+
Processor name string: AMD Athlon(tm) MP Processor 1700+
[root@bart x86info-1.5]# ./x86info -a | grep "name string"
Processor name string: AMD Athlon(tm) MP Processor 1700+
Processor name string: AMD Athlon(tm) MP Processor 1700+

-- 
Jens Axboe

