Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266113AbUF2WOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266113AbUF2WOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUF2WOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:14:52 -0400
Received: from mail.tmr.com ([216.238.38.203]:57609 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266113AbUF2WOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:14:49 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Disk copy, last sector problem
Date: Tue, 29 Jun 2004 18:16:25 -0400
Organization: TMR Associates, Inc
Message-ID: <cbspbv$f56$2@gatekeeper.tmr.com>
References: <600B91D5E4B8D211A58C00902724252C01BC071A@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1088547007 15526 192.168.12.100 (29 Jun 2004 22:10:07 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <600B91D5E4B8D211A58C00902724252C01BC071A@piramida.hermes.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic wrote:
>>From: 	Andries Brouwer[SMTP:aebr@win.tue.nl]
>>
>>On Tue, Jun 22, 2004 at 09:52:54AM -0700, Philippe Troin wrote:
>>
>>>David Balazic <david.balazic@hermes.si> writes:
>>>
>>>
>>>>Hi!
>>>>
>>>>cat /dev/hda > /dev/hdc
>>>>
>>>>This would not copy the entire disk as expected, but miss the last
>>
>>sector if
>>
>>>>the number of
>>>>sectors on hda is odd. ( I used "cat" becasue it has the simplest
>>
>>syntax,
>>
>>>>"dd" and other behave the same ).
>>>>Has this been fixed recently ?
>>>>What about suppport of other sectors sizes, like 8kb ?
>>>
>>>Have you tried setting the device block size to its sector size?
>>>
>>>  blockdev --setbsz $(blockdev --getss /dev/...) /dev/...
>>
>>If I understand correctly David is not reporting a problem, but
>>vaguely recalls that there was a problem in this area long ago,
>>and asks whet the current status is.
>>
>>(Yes, today things are better, but not perfect yet :-))
>>
> 
> So the copy will still miss the last sector ?
> But the blockdev command is a working workaround ?
> Are there any downsides of setting the block size to
> 512 bytes right at boot for all hard drives ?
> What about 8kb sectors, do they work ?

Given that the change from 1k to 4k, I suspect that going to 512 will 
suck rocks off the bottom of the ocean in terms of performance. I don't 
think that 8k works in 2.4, it didn't work in my 2.6, but the error was 
"device busy" so it may not be related to anything but having no spare 
drive.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
