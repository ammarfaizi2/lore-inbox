Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVEPI6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVEPI6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVEPI6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:58:37 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:9877 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261423AbVEPI63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 04:58:29 -0400
Date: Mon, 16 May 2005 14:28:32 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl to keyboard device file
In-Reply-To: <1115892091.18499.17.camel@pegasus>
Message-ID: <Pine.LNX.4.60.0505161418470.31612@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in> 
 <1115831651.23458.74.camel@pegasus>  <Pine.LNX.4.60.0505112301350.31722@lantana.cs.iitm.ernet.in>
  <1115834000.23458.77.camel@pegasus>  <Pine.LNX.4.60.0505121454240.26644@lantana.cs.iitm.ernet.in>
 <1115892091.18499.17.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hai,

     My task is to send the characters to any application as if the input 
is coming from keyboard. For that I created one character device file. To 
it I am sending input characters through ioctl. In the character device 
ioctl definition I am copying these user characters to kernel space and 
sending these characters to handle_scancode function. What is the wrong 
with this solution. This solution is working now. But waht I am asking is
istead of sending our ioctl to newly created device file, can we able to 
send ioctl to the keyboard buffer, so that avoiding the use of new 
character device file , whose purpose is just to handle ioctl.

I think now u got my doubt.

One more is, uinput case,

Whether uinput also doing the same thing, waht I am doing?
For sending user data to kernel sapce we should use ioctl ,is it right?

Plz  cc (mail) me with ur comments.

Regards,
Manohar.
On Thu, 12 May 2005, Marcel Holtmann wrote:

> Hi,
>
>>>>>>       I want to add a new ioctl to keyboard driver device file which will
>>>>>> perform the work of copying user space data  sent to it into kernel
>>>>>> space and send those characters  to handle_scancode function of keyboard
>>>>>> driver.. Now I want to know
>>>>>>
>>>>>> 1) what is the device file corresponding to keyboard (is it
>>>>>> /dev/input/keyboard).
>>>>>> 2) where file operations structure is defined for that.
>>>>>> 3) where the those ioctls handled(not found in keyboard.c).
>>>>>>
>>>>>> Any small help is appreciated.
>>>>>
>>>>> why not using uinput for this job?
>>>>
>>>>    Thanks for the solution.  I did the above task, by defining a new
>>>> character device driver and sending ioctl to it. and calling
>>>> handle_scancode from it. Now I want
>>>> to do the same task with in the keyboard driver. For that I need to send
>>>> ioctl to keyboard device file.
>>>> For that only I asked the
>>>> above doubts.
>>>
>>> what your are trying to do looks wrong to me. Why don't you use uinput.
>>> It is there and it is the correct thing for the job.
>>>
>>
>> Can u pl. tell what uinput will do,
>> Can u have any idea about the way That I want it to do.
>
> with uinput you can write your own input driver (keyboards, mice etc.)
> in the userspace. So you create a keyboard device driven by uinput and
> feed your key strokes from the other machine to it.
>
> Regards
>
> Marcel
>
>
