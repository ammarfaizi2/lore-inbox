Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752269AbWCNRQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbWCNRQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbWCNRQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:16:26 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:52094 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1752269AbWCNRQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:16:26 -0500
Date: Tue, 14 Mar 2006 12:16:23 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Dmesg is not showing whole boot list
In-reply-to: <4416DBC2.8000103@cfl.rr.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200603141216.23335.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200603140901.27746.cijoml@volny.cz>
 <20060314083812.GA27338@brainysmurf.cs.umu.se> <4416DBC2.8000103@cfl.rr.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 10:05, Phillip Susi wrote:
>Or look in your /var/log/kern.log file instead of asking dmesg.  dmesg
>just dumps the kernel ring buffer which is of finite size.  The entire
>contents should be logged to /var/log/kern.log.

You've got to have /var checked and mounted to be able to do that log 
write, if the buffer overflows before that, then the head end of the 
dmesg dump to the /var/log/dmesg file is lost forever.

There is a line that can be changed, in xconfig or by hand, to control 
the memory allocated for this ring buffer.

Finally found it in the xconfig display, left panel line=kernel hacking, 
right panel its under kernel debugging and shows only if thats checked, 
double click on the line that says : kernel log buffer size and enter a 
one digit increment from whats there now, maybe 2, I have mine set for 
16.  Your default may be as low as 14, why I have NDI because 16k sure 
as heck isn't enough if something gets chatty.

>Peter Hagervall wrote:
>> On Tue, Mar 14, 2006 at 09:01:27AM +0100, CIJOML wrote:
>>> Hello,
>>>
>>> maybe this si a wrong list to ask, bug after boot, dmesg shows that
>>> few lines at the beginning are missing.
>>>
>>> Is there any option I can increase to get full dmesg?
>>
>> Try increasing CONFIG_LOG_BUF_SHIFT and recompile. That's likely the
>> source of your problem.
>>
>>
>>
>> 	Peter Hagervall
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
