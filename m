Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272417AbRIFGDn>; Thu, 6 Sep 2001 02:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272422AbRIFGDe>; Thu, 6 Sep 2001 02:03:34 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:43793 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S272417AbRIFGDS>; Thu, 6 Sep 2001 02:03:18 -0400
Date: Thu, 6 Sep 2001 08:03:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Rival <frival@zk3.dec.com>
Cc: Jonathan Lahr <lahr@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010906080329.F576@suse.de>
In-Reply-To: <20010830134930.F23680@us.ibm.com> <20010831075613.A2855@suse.de> <20010831075201.N23680@us.ibm.com> <20010831200333.A9069@suse.de> <20010831113308.A28193@us.ibm.com> <20010903090703.C6875@suse.de> <3B968B82.80405@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B968B82.80405@zk3.dec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05 2001, Peter Rival wrote:
> Jens Axboe wrote:
> >You are now browsing the request list without agreeing on what lock is
> >being held -- what happens to drivers assuming that io_request_lock
> >protects the list? Boom. For 2.4 we simply cannot afford to muck around
> >with this, it's jsut too dangerous. For 2.5 I already completely removed
> >the io_request_lock (also helps to catch references to it from drivers).
> 
> Is this part of the bio patches?  (I confess, I haven't had the time to 
> look yet.)  If not, do you know when we'll be seeing sneak previews of 
> this code?  (Yes, it's me again! ;)

Yep it's part of the bio patch. bio-14 for 2.4.10-preX is pending today
or tomorrow.

-- 
Jens Axboe

