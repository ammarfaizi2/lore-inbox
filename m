Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQJ3TFX>; Mon, 30 Oct 2000 14:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbQJ3TFN>; Mon, 30 Oct 2000 14:05:13 -0500
Received: from [199.239.160.155] ([199.239.160.155]:17171 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129044AbQJ3TFB>; Mon, 30 Oct 2000 14:05:01 -0500
Date: Mon, 30 Oct 2000 11:06:59 -0800
From: rread@datarithm.net
To: Brett Smith <brett.smith@bktech.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: installing an ISR from user code
Message-ID: <20001030110659.A26335@datarithm.net>
In-Reply-To: <39FDAE74.2AED0C74@bktech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FDAE74.2AED0C74@bktech.com>; from brett.smith@bktech.com on Mon, Oct 30, 2000 at 12:23:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm new at this myself, but how about creating a minor number for each
ISR?  When the BH runs, it wakes up the processing waiting on the
device for that ISR.  The user code opens as whatever devices it's
interested in and waits for interrupts using select.


robert

* Brett Smith (brett.smith@bktech.com) [001030 09:25]:
> 
> We have written a char driver for our proprietary h/w.  This driver
> handles a
> multitude of interrupts from the h/w in the following fashion:  The ISR
> reads/saves the status register (indication of which int was hit) in
> global, and the marks the BH to run.  The BH uses the global to call one
> of 32 "ISRs" (an array of func ptrs).  I would like to be able to
> install an "ISR" dynamically from user code (the module has already been
> installed).  Is this possible?
> 
> If it is possible, how does the build/link work?
> 
> thanks,
> brett.smith@bktech.com
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
