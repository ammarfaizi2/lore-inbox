Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVCSTU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVCSTU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 14:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVCSTU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 14:20:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:187 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262656AbVCSTUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 14:20:37 -0500
Date: Sat, 19 Mar 2005 14:26:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: erik.andren@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend-to-disk woes
Message-ID: <20050319132612.GA1504@openzaurus.ucw.cz>
References: <423B01A3.8090501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423B01A3.8090501@gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hello, I experienced a pretty nasty problem a couple of days back:
> 
> I ran 2.6.11-ck1 and built 2.6.11-ck2. The last thing I did before 
> booting the new kernel was to suspend-to-disk the old kernel 
> (something I usually do as I'm working on this laptop).
> I ran the new kernel a couple of days and decided to boot the old 
> kernel to do some performance tests. Imagine my dread as the old 
> kernel instead of detecting that the system has booted another kernel 
> just reloads the old suspend-to-disk image. The result is that after 
> succesfully resuming, my harddrive goes bonkers and starts to work. 
> After a couple of minutes the whole kernel hangs. I reboot and try to 
> boot the -ck2 kernel again only to find that the system complains as 
> it finds missing nodes. The reisertools try to rebuild the system 
> unsucessully. The --rebuild-tree parameter worked but a lot of files 
> were still missing. In the end I had to reinstall the whole system as 
> it went so unstable.
> 
> My question is: Why isn't there a check before resuming a 
> suspend-to-disk image if the system has booted another kernel since 
> the suspend to prevent this kind of hassle?

Checking that would be hard, but you might want to provide patch to check
last-mounted dates of filesystems and panic if they changed.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

