Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbRAaSti>; Wed, 31 Jan 2001 13:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130521AbRAaSt2>; Wed, 31 Jan 2001 13:49:28 -0500
Received: from 4dyn210.com21.casema.net ([212.64.95.210]:58638 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130512AbRAaStQ>;
	Wed, 31 Jan 2001 13:49:16 -0500
Date: Wed, 31 Jan 2001 19:48:57 +0100
From: bert hubert <ahu@ds9a.nl>
To: Nathan Black <NBlack@md.aacisd.com>
Cc: linux-kernel@vger.kernel.org
Subject: how to use and get raw devices
Message-ID: <20010131194856.A22586@home.ds9a.nl>
Mail-Followup-To: Nathan Black <NBlack@md.aacisd.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <8FED3D71D1D2D411992A009027711D671880@md>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <8FED3D71D1D2D411992A009027711D671880@md>; from NBlack@md.aacisd.com on Wed, Jan 31, 2001 at 01:29:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 01:29:05PM -0500, Nathan Black wrote:

> That is what I wanted to do...Write directly to the disk. But the
> kernel(2.4.1) is caching the io...

Is it caching when you do O_SYNC? 

> try opening with O_SYNC, or call fsync() every once in a while. Otherwise,
> this sounds like an application for a raw device, whereby you can write
> directly to the disk, with no caching in between.

A raw device is something different than just /dev/sda1 - a raw device is
created with the 'raw' utility and is assigned /dev/raw or /dev/raw1. This
utility, and some documentation can be found on

     ftp://ftp.linux.org.uk/pub/linux/sct/fs/raw-io/raw-19990728.tar.gz

AFAIK you don't need any patches anymore if you run 2.4 or a recent 2.3.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
