Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbRA2LfO>; Mon, 29 Jan 2001 06:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130287AbRA2LfD>; Mon, 29 Jan 2001 06:35:03 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:36105 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S130093AbRA2Lew>; Mon, 29 Jan 2001 06:34:52 -0500
Date: Mon, 29 Jan 2001 11:34:48 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: swapoff problem in 2.4.0ac9
Message-ID: <Pine.LNX.4.21.0101291132060.26336-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
I was doing some tests over the weekend, and after doing a swapoff -a
and stressing the system, I hit the bad_device: goto in __swap_free():

	printk("swap_free: Trying to free swap from unused 
swap-device\n");

I was compiling kernels at the time. The swap setup was a 200Mb partition
on /dev/hda and a 40Mb partition on /dev/hdb

This was 2.4.0ac9

thanks
john

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
