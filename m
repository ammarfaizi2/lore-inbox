Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbUKXOND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbUKXOND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbUKXOMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:12:50 -0500
Received: from zeus.kernel.org ([204.152.189.113]:33479 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262658AbUKXNaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:30:52 -0500
Message-ID: <41A48CFB.2010304@roma1.infn.it>
Date: Wed, 24 Nov 2004 14:30:35 +0100
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hendrik Wiese <7.e.Q@syncro-community.de>
CC: LKLM <linux-kernel@vger.kernel.org>
Subject: Re: Difference wait_event_interruptible and interruptible_wait_on
References: <41A478F2.3080004@syncro-community.de>
In-Reply-To: <41A478F2.3080004@syncro-community.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hendrik Wiese wrote:

> Hello,
>
> I'm porting a device driver from 2.2.14 to 2.6.7 and I got some 
> problems doing this...
>
> one of them is the following:
> I know that a call to interruptible_wait_on puts a process into sleep 
> state and that wait_event_interruptible does the same. But the 
> difference is that wait_event_interruptible needs a condition to pass 
> to wake up the processes. I do not need that mechanism since I wake up 
> the processes at other places inside my driver with 
> wake_up_interruptible calls. So how do I get a function similar to 
> interruptible_wait_on where no condition is needed using kernel 2.6?

I did not check, so maybe I'm wrong, anyway the condition 
wait_event_interruptible is used to avoid the race window between the 
time you decide to call it and the time the process is actually made to 
sleep and ready to be woken up.
regards

