Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267983AbUHPWYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267983AbUHPWYC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUHPWYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:24:01 -0400
Received: from mail.tmr.com ([216.238.38.203]:58124 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267983AbUHPWXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:23:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: SG_IO and security
Date: Mon, 16 Aug 2004 18:24:02 -0400
Organization: TMR Associates, Inc
Message-ID: <cfrbqb$9bd$1@gatekeeper.tmr.com>
References: <9ac707cb040813122522d4a71@mail.gmail.com><9ac707cb040813122522d4a71@mail.gmail.com> <411D1885.8060904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092694668 9581 192.168.12.100 (16 Aug 2004 22:17:48 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <411D1885.8060904@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Peter Jones wrote:
> 
>> On Thu, 12 Aug 2004 22:22:36 +0300 (EEST), Kai Makisara
>> <kai.makisara@kolumbus.fi> wrote:
>>
>>> On Thu, 12 Aug 2004, Linus Torvalds wrote:
>>>
>>>> Let's see now:
>>>>
>>>>      brw-rw----    1 root     disk       3,   0 Jan 30  2003 /dev/hda
>>>>
>>>> would you put people you don't trust with your disk in the "disk" 
>>>> group?
>>>>
>>>
>>> This protects disks in practice but SG_IO is currently supported by 
>>> other
>>> devices, at least SCSI tapes. It is reasonable in some organizations to
>>> give r/w access to ordinary users so that they can read/write tapes. I
>>> would be worried if this would enable the users, for instance, to 
>>> mess up
>>> the mode page contents of the drive or change the firmware.
>>
>>
>>
>> Sure, but for that we need command based filtering.
> 
> 
> We have that now (sigh).  See attached patch, which is in BK...
> 
> A similar approach could be applied to tape as well.
> 
> Though in general I think command-based filtering is not scalable...  at 
> the very least I would prefer a list loaded from userspace at boot.

It would seem that the list is unlikely to change much, since it would 
presumably be limited to the standard SCSI commands, and require RAWIO 
for vendor commands. Do you see any like change I'm missing?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
