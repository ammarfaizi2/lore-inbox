Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVHBOC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVHBOC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVHBOCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:02:36 -0400
Received: from ds17.reliablehosting.com ([216.131.95.67]:7112 "EHLO
	ds17.reliablehosting.com") by vger.kernel.org with ESMTP
	id S261526AbVHBOBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:01:33 -0400
Message-ID: <42EF7CB7.5090403@bluebottle.com>
Date: Tue, 02 Aug 2005 18:01:27 +0400
From: Gene Pavlovsky <heilong@bluebottle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFE: console_blank_hook that calls userspace helper
References: <1122891737.42edf7d9a402a@www.bluebottle.com> <20050802110418.GB1390@elf.ucw.cz>
In-Reply-To: <20050802110418.GB1390@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can try to do this, but it will have to wait, I've got too much work now.
Don't you think the userspace solution deserves a try?

Pavel Machek wrote:
> Hi!
> 
> 
>>http://bugzilla.kernel.org/show_bug.cgi?id=4767:
>>
>>Bugzilla Bug 4767 	RFE: console_blank_hook that can call userspace
>>program
>>Submitter:   	heilong@bluebottle.com (Eugene Pavlovsky)
>>
>>I think it'd be very good to have a console_blank_hook handler that
>>would call a
>>userspace program/script/generate hotplug event whatever. Currently,
>>the console
>>can only be blanked using APM, so no options exist for people using
>>ACPI. I've
>>got a Radeon graphics chip on my laptop, and the LCD backlight can be
>>controlled
>>(on/off) using radeontool. If there was a userspace callback
>>interface
>>to
>>console blanking, I would just make a callback script that calls
>>"radeontool
>>light off" on blank and "radeontool light on" on unblank - really
>>easy. I think
>>this userspace console_blank_hook handler is very simple to put into
>>kernel, but
>>I'm not a kernel developer myself, so wouldn't risk sending any
>>patches (that
>>call system("some_script")), because I probably won't make things as
>>they should
>>be in the kernel.
> 
> 
> Radeonfb should blank console automatically, without userspace
> helper. Send a patch to do that ;-).
> 
> 								Pavel
> 

-- 
The human knowledge belongs to the world
