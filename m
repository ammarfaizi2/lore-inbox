Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUHXV6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUHXV6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUHXV6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:58:46 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:54952 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268367AbUHXV46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:56:58 -0400
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>, axboe@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040824144707.100e0cfd.akpm@osdl.org>
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
	 <m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de>
	 <m3hdqsckoo.fsf@telia.com>  <20040824144707.100e0cfd.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1093384621.817.76.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 17:57:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 17:47, Andrew Morton wrote:
> Peter Osterlund <petero2@telia.com> wrote:
> > 
> > Why is it not nice? If the VM has decided to create 400MB of dirty
> > data on a DVD+RW packet device, I don't see a problem with submitting
> > all bio's at the same time to the packet device.
> 
> We also have a limit on the number of in-flight requests:
> /sys/block/sda/queue/nr_requests.  It defaults to 128.
> 
> Are you saying that your requests are so huge that each one has 1000 BIOs? 
> That would be odd, for an IDE interface.
> 

This defaults to 8192 on my (IDE) system.  IIRC this value is larger if
48-bit addressing is in use (drive size > ~128GB).  It does not seem
right to me that the size of your hard drive should dictate the amount
of I/O allowed to be in flight.

Lee

