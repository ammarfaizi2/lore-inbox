Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbUKXM3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbUKXM3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 07:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbUKXM3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 07:29:23 -0500
Received: from knserv.hostunreachable.de ([212.72.163.70]:51678 "EHLO
	mail.hostunreachable.de") by vger.kernel.org with ESMTP
	id S262628AbUKXM3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 07:29:20 -0500
Message-ID: <41A478F2.3080004@syncro-community.de>
Date: Wed, 24 Nov 2004 13:05:06 +0100
From: Hendrik Wiese <7.e.Q@syncro-community.de>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKLM <linux-kernel@vger.kernel.org>
Subject: Difference wait_event_interruptible and interruptible_wait_on
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm porting a device driver from 2.2.14 to 2.6.7 and I got some problems 
doing this...

one of them is the following:
I know that a call to interruptible_wait_on puts a process into sleep 
state and that wait_event_interruptible does the same. But the 
difference is that wait_event_interruptible needs a condition to pass to 
wake up the processes. I do not need that mechanism since I wake up the 
processes at other places inside my driver with wake_up_interruptible 
calls. So how do I get a function similar to interruptible_wait_on where 
no condition is needed using kernel 2.6?

Thanks a lot and please CC me, 'cos I haven't subscribed to the LKML yet.

Kind regards,
Hendrik
