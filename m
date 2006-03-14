Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWCNSej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWCNSej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWCNSej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:34:39 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:38080 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751246AbWCNSei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:34:38 -0500
Date: Tue, 14 Mar 2006 13:34:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Dmesg is not showing whole boot list
In-reply-to: <644428B9-6AE0-40D4-A7CE-F4C6540F0F69@mac.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200603141334.24517.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200603140901.27746.cijoml@volny.cz>
 <200603141216.23335.gene.heskett@verizon.net>
 <644428B9-6AE0-40D4-A7CE-F4C6540F0F69@mac.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 12:28, Kyle Moffett wrote:
>On Mar 14, 2006, at 12:16:23, Gene Heskett wrote:
>> On Tuesday 14 March 2006 10:05, Phillip Susi wrote:
>>> Or look in your /var/log/kern.log file instead of asking dmesg.
>>> dmesg just dumps the kernel ring buffer which is of finite size.
>>> The entire contents should be logged to /var/log/kern.log.
>>
>> You've got to have /var checked and mounted to be able to do that
>> log write, if the buffer overflows before that, then the head end
>> of the dmesg dump to the /var/log/dmesg file is lost forever.
>>
>> There is a line that can be changed, in xconfig or by hand, to
>> control the memory allocated for this ring buffer.
>>
>> Finally found it in the xconfig display, left panel line=kernel
>> hacking, right panel its under kernel debugging and shows only if
>> thats checked, double click on the line that says : kernel log
>> buffer size and enter a one digit increment from whats there now,
>> maybe 2, I have mine set for 16.  Your default may be as low as 14,
>> why I have NDI because 16k sure as heck isn't enough if something
>> gets chatty.
>
>To continue this point; on my desktop I have root/var/tmp/vicepa-on-
>LVM-on-RAID5, boot-on-RAID1, and swap-on-RAID1, so I would easily
>overflow the default SMP dmesg buffer size in messages well before
>syslogd/bootlogd got started.  I finally ended up having to increment
>the default by 3 in order to have the boot messages still available
>after booting.  It would be nice if we could quiet down some of the
>more excessively verbose kernel messages, there's a lot of mostly-
>irrelevant spew that chews up log buffer space.

I think thats somewhat true but then when you need that info for 
figureing out what didn't work, its priceless.  The only thing I'd 
stick a hot potato in is ACPI, its turned off in the config and still 
supplies about 5k of its mewling on boot.  But my /proc/interrupts says 
its not working, which is what counts so I can keep good time with 
ntpd.

>Cheers,
>Kyle Moffett

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
