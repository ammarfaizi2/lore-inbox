Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUBDVan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266576AbUBDVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:30:37 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:5530 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266574AbUBDVaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:30:20 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 4 Feb 2004 22:28:41 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
Message-ID: <20040204212841.GA9205@bytesex.org>
References: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu> <Pine.GSO.4.58.0402041529160.7454@denali.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402041529160.7454@denali.ccs.neu.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While doing a large network transfer, and not at any other time, I get
> tons of messages like this from the kernel:
> 
> Feb  4 15:14:05 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=0
> Feb  4 15:14:06 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=1
> 
> I do have a hauppauge remote which works great under the 2.6 kernels
> (thanks Gerd), but I am not pressing any keys while this is happening.

Hmm, what happens if you rmmod the ir-kbd-i2c module?  Any difference?

>   3 root      35  19     0    0    0 S 45.9  0.0   0:46.98 ksoftirqd/0
>   6 root       5 -10     0    0    0 S 43.3  0.0   1:56.63 events/0

One of the two could be ir-kbd-i2c, it polls the i2c IR chip using tasklets.
Not sure which of the kernel threads runs the tasklets ...

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
