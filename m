Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTICU3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTICU22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:28:28 -0400
Received: from [129.219.49.179] ([129.219.49.179]:13208 "EHLO nwn.nanovoid.com")
	by vger.kernel.org with ESMTP id S264214AbTICU12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:27:28 -0400
Message-ID: <3F564EAE.20805@nanovoid.com>
Date: Wed, 03 Sep 2003 14:27:26 -0600
From: "Blake B." <shadoi@nanovoid.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test 4 and USB
References: <Pine.LNX.3.96.1030903154731.9300A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030903154731.9300A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... once I mounted the usbfs, and had the proper modules loaded 
(uhci-usb, etc...) /proc/bus/usb was populated.

My guess is the appropriate modules are not being loaded for whatever 
hardware you/they have.

-b-

Bill Davidsen wrote:
>>Read /linux-kernel-source/Documentation/usb/proc_usb_info.txt
> 
> 
> I must be missing something, the mount command from that file doesn't
> seem to solve the original poster's problem, the /proc/bus/usb is still
> empty...
> 
> ================================================================
> 
> From root@oddball.prodigy.com Wed Sep  3 15:47:22 2003
> Subject: USB proc stuff
> From: root <root@oddball.prodigy.com>
> Date: Wed, 3 Sep 2003 13:19:15 -0400
> To: davidsen@tmr.com
> 
> oddball:root> mount -t usbfs none /proc/bus/usb
> oddball:root> df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/hda3              2522076   2338380     55580  98% /
> /dev/hda1                23302     20030      2069  91% /boot
> /dev/hda5              1510032    265388   1167936  19% /home
> /dev/hdb3              1474320    897712    501716  65% /usr/src
> none                     46776         0     46776   0% /dev/shm
> oddball:root> mount -t usbfs none /proc/bus/usb
> mount: none already mounted or /proc/bus/usb busy
> mount: according to mtab, none is already mounted on /proc/bus/usb
> oddball:root> lc /proc/bus/usb
> oddball:root> l -aR /proc/bus/usb
> /proc/bus/usb:
> total 0
> drwxr-xr-x    2 root            0 Sep  3 13:17 .
> dr-xr-xr-x    6 root            0 Sep  3 13:17 ..
> oddball:root> lc /sys/b
> block  bus
> oddball:root> lc /sys/bus/usb/
> devices/  drivers/
> oddball:root>
> ================================================================
> 
> I did the mount, checked that it worked, and the data still seems
> missing. Before you ask, lc is an alias for "ls -CF" and a leftover
> reflex from a previous o/s.
> 
> I did drag and drop on the mount command from the file you quote, o/s is
> 2.4.0-test4 with only Nick's v7 scheduler patch.
> 


