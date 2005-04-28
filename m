Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVD1WBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVD1WBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVD1WBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:01:03 -0400
Received: from free-electrons.com ([80.68.91.110]:12558 "EHLO
	electrons.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S262257AbVD1WAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:00:54 -0400
Message-ID: <42715D0E.7020108@free-electrons.com>
Date: Fri, 29 Apr 2005 00:00:46 +0200
From: Michael Opdenacker <michael@free-electrons.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050417 Fedora/1.7.7-1.3.1
X-Accept-Language: en
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: dumb question: How to create your own log files in a kernel module?
References: <4ae3c14050428111073283bd3@mail.gmail.com>	 <Pine.LNX.4.61.0504281557510.29750@chaos.analogic.com> <4ae3c1405042813591f0b5962@mail.gmail.com>
In-Reply-To: <4ae3c1405042813591f0b5962@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

>I know printk can do this job. But what I really want is to print logs
>to a file specified by me instead of /var/log/messages. And, the
>messages irrelevant to my module should not be written into that file.
> Now my log mixed with other logs in /var/log/message, which bother me
>much. :(
>
You seem to make a confusion here...

Don't forget that files are only an abstraction for userspace. They are 
only meant to be read and written from userspace. Kernel code can never 
read or write files. In the case of /var/log/messages, this file is 
created by the syslogd program from the kernel buffer, not by the kernel 
itself.

You could just echo something specific to your driver in your printk 
strings, and grep this specific thing in /var/log/messages. You have 
your file!

    Cheers,

    Michael.

-- 
Michael Opdenacker
http://free-electrons.com
+33 621 604 642

