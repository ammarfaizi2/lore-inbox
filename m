Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTIYPVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 11:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTIYPVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 11:21:01 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:3336 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261294AbTIYPU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 11:20:59 -0400
Message-ID: <3F730637.8080406@rackable.com>
Date: Thu, 25 Sep 2003 08:13:59 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bradley Chapman <kakadu_croc@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test broke RPM 4.2 on Red Hat 9 in a VERY weird way
References: <20030925132630.59015.qmail@web40903.mail.yahoo.com>
In-Reply-To: <20030925132630.59015.qmail@web40903.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2003 15:20:57.0944 (UTC) FILETIME=[9EC39D80:01C38378]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman wrote:
> I've just discovered a very strange and unusual problem with rpm on my Red Hat 9
> laptop running 2.6.0-test. Under 2.4.22-ac2 rpm runs perfectly fine, but when I
> run it under 2.6.0-test, it outputs the following errors:
> 
> sudo rpm -Uvh alsa-driver-0.9.6-1.fr.i386.rpm
> Password:
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages index using db3 - Resource temporarily unavailable (11)
> error: cannot open Packages database in /var/lib/rpm
> warning: alsa-driver-0.9.6-1.fr.i386.rpm: V3 DSA signature: NOKEY, key ID e42d547b
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages database in /var/lib/rpm
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages database in /var/lib/rpm
> 
> I have never seen rpm do this before, and it only occurs under 2.6.0-test. It
> happens under these specific kernels:
> 
> 2.6.0-test5-bk10
> 2.6.0-test5-bk11
> 2.6.0-test5-mm4
> 
> I have not tried -test5-bk12 yet, but I have a feeling that I will get the same
> errors. I have checked syslog and dmesg and there are no errors from the kernel;
> under 2.4.22-ac2 rpm works perfectly fine, so I don't believe it's file corruption
> or filesystem breakage.
> 
> Does anyone have any ideas that I can try?
>

    Sound like NPTL issues "LD_ASSUME_KERNEL=2.4.1 <rpm command>". 
Check the archives for details.


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

