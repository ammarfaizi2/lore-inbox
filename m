Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759056AbWLDICp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759056AbWLDICp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 03:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759060AbWLDICp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 03:02:45 -0500
Received: from mail.syneticon.net ([213.239.212.131]:33226 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP
	id S1759056AbWLDICp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 03:02:45 -0500
Message-ID: <4573D5FE.3070902@wpkg.org>
Date: Mon, 04 Dec 2006 09:02:06 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
References: <4572B30F.9020605@wpkg.org> <jewt592oxf.fsf@sykes.suse.de> <4572BBE0.4010801@wpkg.org> <20061203154936.GB26669@kallisti.us> <45732C8E.4060801@wpkg.org> <20061203234202.GL7114@grifter.jdc.home>
In-Reply-To: <20061203234202.GL7114@grifter.jdc.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Crilly wrote:
> On 12/03/06 08:59:10PM +0100, Tomasz Chmielewski wrote:
>> Ross Vandegrift wrote:
>>> On Sun, Dec 03, 2006 at 12:58:24PM +0100, Tomasz Chmielewski wrote:
>>>> You mean the "Used by" column? No, it's not used by any other module 
>>>> according to lsmod output.
>>>>
>>>> Any other methods of checking what uses /dev/sda*?
>>> There's a good chance that if it was loaded at system boot, hald or
>>> udev may be doing something with it.
>> This machine doesn't have hal; when I kill udevd still doesn't help.
>>
>> Yes, something's using that drive, be it a program, a module (unlikely), 
>> or something that is compiled directly in the kernel (for example, 
>> md/raid1).
>> But what is it?
>>
>> Kernel knows it, as it refuses to remove the module (via rmmod), but how 
>> to tell kernel to share this knowledge with me?
>>
> 
> Have you checked to make sure there's no swap partitions on it being
> automatically activated at boot? Also, have you checked the output of lsof?

The machine doesn't even have swap, so no, no swap on that device 
(confirmed by th output of free with 0 swap).
The device doesn't also show up in /etc/fstab.

And "lsof -n | grep sd" doesn't show anything.


-- 
Tomasz Chmielewski
http://wpkg.org
