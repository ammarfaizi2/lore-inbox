Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTJPKRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTJPKRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:17:14 -0400
Received: from shark.pro-futura.com ([161.58.178.219]:17596 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S262788AbTJPKRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:17:13 -0400
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
To: "Suresh Subramanian" <Suresh.Subramanian@lntinfotech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Problems in Device Driver Development
Date: Thu, 16 Oct 2003 12:19:23 +0200
User-Agent: KMail/1.5.1
References: <OF7B0779CA.CA76EC51-ON65256DC1.002FABA8@lntinfotech.com>
In-Reply-To: <OF7B0779CA.CA76EC51-ON65256DC1.002FABA8@lntinfotech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310161219.23803.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1.   We are not able to use copy_to_user() a chunk of memory from 'write'
> function of the device driver. The pointer in the user space is passed to
> the kernel space through the 'ioctl' function of the device driver.

I am sure you get some return value from that function wich tells you what the 
problem is...

> 2.    We are not able to send a signal using kill_fasync() from within a
> kernel thread, to an user space process. The problem we face when we do
> this is that we get an OOPS message. I tried hard to decode this message,
> but in vain. So we came to the conclusion that i cannot send a signal from
> within the kernel thread using kill_fasync to a process that is running in
> the user space. Am i right in my conclusion, if not what should i do to
> make it possible.
>
> 3.   Similar to problem numbered 2, we face same problems in doing with
> 'tasklets'.

kill_fasync() works just fine if used properly.

Try to find Linux Device Drivers 2nd edition online book, it can explain this 
basic question to you.

