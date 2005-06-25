Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263282AbVFYCiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbVFYCiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 22:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbVFYCiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 22:38:24 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4993 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S263282AbVFYCiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 22:38:19 -0400
Date: Fri, 24 Jun 2005 20:37:23 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 0xffffe002 in ??
In-reply-to: <4ito6-TJ-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42BCC363.4020605@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4i8jP-156-9@gated-at.bofh.it> <4ito6-TJ-7@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KV Pavuram wrote:
> I think the threads are going into that strange
> address when they are waiting over an IPC object like
> semaphore or mutex. Atleast i saw a thread come out of
> that strange address immed. after another threads
> released a semaphore!!
> 
> Thanks for the inputs.

We've seen that behavior on Red Hat 9 at work as well. However, when we 
moved up to the Fedora Core 1 2.4.22 kernel (due to some apparent 
futex/NPTL bugs in the RH9 kernel) we noticed that the correct pthread 
call was listed in the stack trace.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


