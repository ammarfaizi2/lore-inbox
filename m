Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUAaO2c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 09:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUAaO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 09:28:32 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14601 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264879AbUAaO23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 09:28:29 -0500
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
Content-Type: text/plain
Message-Id: <1075559305.792.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 31 Jan 2004 15:28:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-31 at 04:06, Jim Faulkner wrote:
> There is a major networking performance problem on my machine under recent
> 2.6 kernels.  I have a dual Athlon-MP machine with an onboard Intel
> Ethernet Pro 100 device, which can use either the e100 or eepro100 driver.
> 
> I ran some tests under 2.4 and recent 2.6 kernels to see what kind of
> performance I could get.  I tested using both ftp and samba, the client
> machine is a windows box with an onboard 3com 3c920b controller.  They
> are connected through a D-Link 100 megabit full duplex switch.
> 
> Under both 2.6.2-rc2 and 2.6.2-rc2-mm2, the performance is pretty bad.
> Copying 4.3 gigabytes of data from the linux machine to the windows box
> via samba takes about 35 minutes.  LFTP shows FTP transfers from the linux
> box to the windows box to go at about 2 megabytes per second.  The
> performance is even worse in the opposite direction, LFTP shows transfers
> from the linux box to the windows box to be around 1.5 megabytes per
> second.
> 
> I repeated the above tests with both the e100 driver and the eepro100
> driver and got the same results.  Running ifconfig shows "errors:0
> dropped:0 overruns:0 frame:0" and "errors:0 dropped:0 overruns:0
> carrier:0 collisions:0" for the device.
> 
> Unfortunately my OS (unstable Gentoo) does not appear to support 2.4
> kernels anymore, so I had to use a Knoppix CD to test 2.4 kernels.  I am
> using Knoppix nov 19 2003 version, which I believe uses a 2.4.21 or 2.4.22
> kernel.  It uses the eepro100 driver.
> 
> Under the Knoppix 2.4 kernel, using the exact same samba configuration
> file, I was able to copy 4.3 gigabytes of data from the linux machine to
> the windows machine in about 8 minutes.  Copying in the opposite direction
> takes about 10 minutes.  Unfortunately Knoppix doesn't include an FTP
> server so I wasn't able to test that.
> 
> It appears that my network device is capable of 4 times the throughput
> under 2.4 kernels versus recent 2.6 kernels.  I believe this problem arose
> recently, probably sometime since 2.6.0, since I only recently noticed
> this performance issue.
> 
> I don't know if this problem is specific to my configuration or not, so
> included below is lots of configuration information.  Please note that the
> funky modules like nvidia, vmware and cbm were not loaded when I ran my
> tests.

I have experienced lower network performance with 2.6 kernels and 3Com
cards. On my laptop, downstream traffic (download) seems to get nearly
full throughput (~10MB/s) but upstream traffic never rises from 3MB/s.
On other computers, the throughput is more symmetric, but not as good as
it was with 2.4 kernels. The problem seems to be related with a possible
hardware bug on my 3Com card, but I have been unable to confirm.

