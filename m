Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264796AbUD1OEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbUD1OEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbUD1OEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:04:15 -0400
Received: from mail.tmr.com ([216.238.38.203]:45576 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264796AbUD1OAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:00:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Load hid.o module synchronously?
Date: Wed, 28 Apr 2004 10:02:15 -0400
Organization: TMR Associates, Inc
Message-ID: <c6od9g$53k$1@gatekeeper.tmr.com>
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>	<408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1083160688 5236 192.168.12.100 (28 Apr 2004 13:58:08 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <s5gisfm34kq.fsf@patl=users.sf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick J. LoPresti wrote:
> Chris Friesen <cfriesen@nortelnetworks.com> writes:
> 
> 
>>Patrick J. LoPresti wrote:
>>
>>
>>>For example, I invoke "modprobe hid" to make my USB keyboard work.
>>>This loads the module and exits immediately, causing my script to
>>>proceed, before the USB keyboard is probed and ready.
>>>I want to wait until the driver is finished initializing (i.e., a USB
>>>keyboard is either found or not found) before my script continues.
>>>How can I do that?
>>
>>How about scanning the usb device tree to see if the keyboard is
>>present and properly detected?
> 
> 
> You mean under sysfs or usbfs?  Or both?
> 
> I see how I can scan for a USB keyboard after loading the USB host
> controller module.  I think.  But what do I look for, exactly, to tell
> when hid.o has hooked itself up to the keyboard?

You need to be able to tell "not hooked yet" from "never saw it" for 
reliable operation. I don't know how to do that, sorry.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
