Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933964AbWKWVEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933964AbWKWVEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933957AbWKWVEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:04:30 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:697 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933986AbWKWVE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:04:29 -0500
Message-ID: <45660CDA.6090806@garzik.org>
Date: Thu, 23 Nov 2006 16:04:26 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: G.Ohrner@post.rwth-aachen.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org>
In-Reply-To: <ek2nva$vgk$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunter Ohrner wrote:
> Hi!
> 
> (PEBKAC warning. I'm probably doing something dump. I just don't know
> what...)
> 
> I seem to have an entropy pool on a headless machine which is not nearly
> empty (a common problem in this case, I know), but completely empty and
> stuck in this state...
> 
> Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
> 0
> Hornburg:~# fuser /dev/urandom
> Hornburg:~# lsof | grep random
> Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
> 0
> Hornburg:~# dd if=/dev/hdf of=/dev/urandom bs=512 count=1
> 1+0 records in
> 1+0 records out
> 512 bytes transferred in 0.016268 seconds (31473 bytes/sec)
> Hornburg:~# dd if=/dev/hdf of=/dev/random bs=512 count=1
> 1+0 records in
> 1+0 records out
> 512 bytes transferred in 0.031943 seconds (16029 bytes/sec)
> Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
> 0
> Hornburg:~# fuser /dev/urandom
> Hornburg:~# fuser /dev/random
> Hornburg:~# lsof | grep random
> Hornburg:~# cat /proc/sys/kernel/random/poolsize
> 4096
> Hornburg:~#
> 
> Also causing disk activities doesn't help at all. (Two disks on a Promise
> PDC20268 controller.)
> 
> The system runs a rather ancient Debian Sarge 2.4 kernel:
> Linux Hornburg 2.4.27-3-386 #1 Thu Sep 14 08:44:58 UTC 2006 i486 GNU/Linux
> 
> However as the machine itself is also ancient, the 2.4 seems like a good
> match. And also 2.4 ought to have a refilling entropy pool, doesn't it?
> 
> Maybe someone can shed some light on what's happening here...

Grab an entropy generator like egd or audio-entropyd, etc.

	Jeff



