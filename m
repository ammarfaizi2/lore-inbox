Return-Path: <linux-kernel-owner+w=401wt.eu-S1751856AbWLNXVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWLNXVb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWLNXVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:21:30 -0500
Received: from mail.velocitynet.com.au ([203.17.154.25]:48914 "EHLO
	m0.velocity.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbWLNXV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:21:28 -0500
Message-ID: <4581DC71.5000503@iinet.net.au>
Date: Fri, 15 Dec 2006 10:21:21 +1100
From: Ben Nizette <ben.nizette@iinet.net.au>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: Re: [GIT PATCH] more Driver core patches for 2.6.19]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 14 Dec 2006, Thomas Gleixner wrote:
>   
>> The kernel part of the UIO driver also knows how to shut the interrupt
>> up, so where is the difference ?
>>     
>
> Thomas, you've been discussing some totally different and private 
> Thomas-only thread than everybody else in this thread has been.
>
> The point is NO, THE UIO DRIVER DID NOT KNOW THAT AT ALL. Go and read the 
> post that STARTED this whole thread. Go and read the "example driver". 
>
> The example driver was complete crap and drivel. 
>   
OK the example driver was a bad example.  A very bad example.  Writing a
driver with UIO does involve writing _some_ kernel code, just not much.
Some of the kernel code you do have to write is the bit of the interrupt
routine which shuts the device up.  UIO doesn't really move the
interrupt handling to userspace, more it moves the bottom-half work to
userspace.  If you are using UIO, a prerequisite is probably that your
actual interrupt handler code is trivial, all work can be done in this
form of userspace bottom-half.

The example didn't show that, the docco shipped with the UIO patches does.

        Ben.
