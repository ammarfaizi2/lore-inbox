Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWGFPT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWGFPT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWGFPTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:19:55 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:38452 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1030299AbWGFPTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:19:55 -0400
Message-ID: <44AD286F.3030507@emc.com>
Date: Thu, 06 Jul 2006 11:12:47 -0400
From: Ric Wheeler <ric@emc.com>
Reply-To: ric@emc.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl>
In-Reply-To: <20060701181702.GC8763@irc.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.7.6.75432
X-PerlMx-Spam: Gauge=, SPAM=2%, Reasons='EMC_FROM_0+ -2, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:

>On Sat, Jul 01, 2006 at 07:47:16PM +0200, Thomas Glanzmann wrote:
>  
>
>>Hello,
>>    
>>
>>>Checksums are not very useful for themselves. They are useful when we
>>>have other copy of data (think raid mirroring) so data can be
>>>reconstructed from working copy.
>>>      
>>>
>>it would be possible to identify data corruption.
>>    
>>
>
>  Yes, but what good is identification? We could only return I/O error.
>Ability to fix corruption (like ZFS) is the real killer.
>  
>

Having a checksum (or even a digital signature on a file) that lets us 
detect corruption is very useful since, in many cases, it allows us to 
flag the file as corrupt before it gets used.

In some cases, this is a big hint that you should restore it from backup 
(tape, other disk, etc).

I think that it is a generally useful thing even when not on a self 
correcting device,

ric

