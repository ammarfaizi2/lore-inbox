Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162096AbWKPANU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162096AbWKPANU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162094AbWKPANU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:13:20 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:13539 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1162093AbWKPANS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:13:18 -0500
Date: Thu, 16 Nov 2006 01:02:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mark Lord <lkml@rtr.ca>
cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Pavel Machek <pavel@ucw.cz>,
       Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>,
       John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
Subject: Re: HD head unloads
In-Reply-To: <Pine.LNX.4.61.0611151157000.19772@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0611160056540.18761@yvahk01.tjqt.qr>
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz>
 <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de>
 <455893E5.4010001@garzik.org> <4558B232.8080600@rtr.ca> <20061113220127.GA1704@elf.ucw.cz>
 <20061114034355.GB5810@khazad-dum.debian.net> <Pine.LNX.4.61.0611141021040.29913@yvahk01.tjqt.qr>
 <455A05C2.6080508@rtr.ca> <Pine.LNX.4.61.0611151157000.19772@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 15 2006 11:58, Jan Engelhardt wrote:
>On Nov 14 2006 13:06, Mark Lord wrote:
>> Jan Engelhardt wrote:
>>> 
>>> Let me jump in here. Short info: Toshiba MK2003GAH 1.8" 20GB PATA
>>> harddisk, in a Sony Vaio U3 (x86, gray-blue PhoenixBIOS).
>>> If idle for more than 5 secs, unloads. Even when not inside any OS, which
>>> really sets me off.
>>>    So I wrote a quick workaround hack for Linux, http://tinyurl.com/y3qs6g
>>> It reads a predefined amount of bytes (just as much to not cause slowdown
>>> yet still cause it to not unload) from the disk at fixed intervals.
>>
>> Thanks for the info.
>> Jan, in your specific case, can you not "fix it" properly with:
>>
>>   hdparm -B255 /dev/?d?
>
>No not really. The unload threshold only raises up to about 15 seconds.

-B254 was more promising: unload timeout was like 2
minutes. What's more: upon every reboot, the power
management value is set back to 128.
    I guess I'll stay with thkd.ko for more time.

	-`J'
-- 
