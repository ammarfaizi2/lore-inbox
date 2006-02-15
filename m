Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423040AbWBOIsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423040AbWBOIsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423041AbWBOIsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:48:37 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:35007 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1423040AbWBOIsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:48:36 -0500
thread-index: AcYyDImllSRuS0SnQPWa+s68cTmMUQ==
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Message-ID: <43F2EAC6.6070505@bfh.ch>
Date: Wed, 15 Feb 2006 09:48:06 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kaiwan N Billimoria" <kaiwan@designergraphix.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Stuck creating sysfs hooks for a driver..
References: <pan.2006.02.15.08.46.27.708727@bfh.ch>
In-Reply-To: <pan.2006.02.15.08.46.27.708727@bfh.ch>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 08:48:05.0564 (UTC) FILETIME=[89915FC0:01C6320C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Feb 2006 13:24:28 +0530, Kaiwan N Billimoria wrote:
> 
> 
>Hello All,
>
>I am in the process of porting a 2.4 temperature sensor device driver (the National 
>Semiconductor LM70CILD-3 temperature sensor eval board) to the 2.6 Linux kernel 
>(specifically to v 2.6.15.3 <http://2.6.15.3>), with the intention of submitting it for inclusion. 
>All ok, except this: am stuck on inserting an entry in /sys instead of /proc for the
>driver (as that is suggested as the new "correct" interface to userspace).
>
>I have read some documentation on sysfs and Rubini's lddbus example in
>the LDD3 book; however, i am still a little confused: do we really need
>to create a new /sys/bus/<driver_name> for each device inserted into
>the lernel at runtime? if (probably) not, where _exactly_ do i create
>my entry, and of course, _how _ exactly?
>
>FYI, my driver is a char driver and does not require a major/minor pair as the UI is via proc, 
>and hopefully now, sysfs.
>(For those interested, pl find the source here: http://www.designergraphix.com/kaiwan/projects/lm70CILD3.c )
>
>So i guess what i'm also trying to say is this: as i don't require a major/minor pair, i'm abviously
>not using register_chrdev() or the cdev() interface..hence i don't have a kobject and auto-inclusion in
>the sysfs tree (isn't that right?). So... how exactly do i get my sysfs hooks in - as the 
>device_create_file() API requires struct device and struct device_attribute parameters.
>
>Have any of you come across sample code/howto/tutorial out there that demonstrates just this (creating 
>arbitrary sysfs hooks)? Request your help as i'm stuck here...(i also looked through
>Documentation/filesystems/sysfs.txt but was unable to properly map it to code...  ). 
>
>Perhaps, as the usual googling did not turn up a full-fledged howto on this topic, it's time for a 
>knowledgeable person(s) out there to write one? I feel this would be v useful in the Documentation/ branch..
>Just a suggestion..
>
>TIA, kaiwan.
> 
> 

Hmmm...

I don't know if this'll really help, but have a look at
drivers/firmware/edd.c
