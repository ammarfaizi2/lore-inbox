Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132650AbRAaRv7>; Wed, 31 Jan 2001 12:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132648AbRAaRvv>; Wed, 31 Jan 2001 12:51:51 -0500
Received: from 4dyn210.com21.casema.net ([212.64.95.210]:43790 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S132640AbRAaRvk>;
	Wed, 31 Jan 2001 12:51:40 -0500
Date: Wed, 31 Jan 2001 18:51:21 +0100
From: bert hubert <ahu@ds9a.nl>
To: Nathan Black <NBlack@md.aacisd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drive/block device write scheduling, buffer flushing?
Message-ID: <20010131185120.B3287@home.ds9a.nl>
Mail-Followup-To: Nathan Black <NBlack@md.aacisd.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <8FED3D71D1D2D411992A009027711D67187E@md>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <8FED3D71D1D2D411992A009027711D67187E@md>; from NBlack@md.aacisd.com on Wed, Jan 31, 2001 at 11:52:25AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 11:52:25AM -0500, Nathan Black wrote:
> I was wondering if there is a way to make the kernel write to disk faster. 
> I need to maintain a 10 MB /sec write rate to a 10K scsi disk in a computer,
> but it caches and doesn't start writing to disk until I hit about 700 MB. At
> that point, it pauses(presumably while the kernel is flushing some of the
> buffers) and I will have missed data that I am trying to capture.

try opening with O_SYNC, or call fsync() every once in a while. Otherwise,
this sounds like an application for a raw device, whereby you can write
directly to the disk, with no caching in between.

Regards,

bert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
