Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267468AbUHEBsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267468AbUHEBsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUHEBsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:48:08 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:49291 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267468AbUHEBsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 21:48:04 -0400
Message-ID: <4111908C.5070903@yahoo.com.au>
Date: Thu, 05 Aug 2004 11:42:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Zan Lynx <zlynx@acm.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc2-mm2, staircase sched and ESD
References: <1091655857.3088.10.camel@localhost.localdomain> <cone.1091658687.786019.9775.502@pc.kolivas.org>
In-Reply-To: <cone.1091658687.786019.9775.502@pc.kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Zan Lynx writes:
>
>> The 2.6.8-rc2-mm2 kernel has the staircase scheduler, right?  Well, I am
>> seeing an odd thing.  At least, I think it is odd.
>>
>> I'm running Fedora Core 2 and playing music with Rhythmbox.  When I
>> watch top sorted by priority, I see esd slowly increase its priority
>> until it reaches 38, then it goes back to 20.  ESD is only using 1-2%
>> CPU.
>>
>> This is causing a problem because doing just about anything in X, like
>> bring up a new window or drag a window causes the sound to just stop.
>>
>> Why does ESD's priority keep climbing?
>>
>> Oh yes, this does not happen if I change /proc/sys/fs/interactive to 
>> 0. When it is 0, X's priority climbs faster than ESDs and does not cause
>> the problem.
>
>
> Yes this is a known issue with esd. It basically wakes up far too 
> frequently for it's own good. esd should not be required with alsa 
> drivers and 2.6 since alsa supports sharing of the sound card / mixing 
> on it's own so adding esd adds an unnecessary layer to the sound 
> drivers. It ends up doing this:
> esd->oss emulation->alsa.
>

Even so, this would be a showstopper if we're talking about replacing 
the 2.6 scheduler,
wouldn't you agree?

