Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVCVX7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVCVX7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVCVX7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:59:46 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7024 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262507AbVCVX6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:58:30 -0500
Date: Tue, 22 Mar 2005 17:57:11 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: lseek on /proc/kmsg
In-reply-to: <3KXou-8ft-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4240B0D7.4000209@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3KWsu-7dO-13@gated-at.bofh.it> <3KXeQ-83A-7@gated-at.bofh.it>
 <3KXou-8ft-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Tue, 22 Mar 2005, Jan Engelhardt wrote:
> 
>> Hi,
>>
>>> how am I supposed to clear the kmsg buffer since it's not a terminal??
>>
>>
>> fd = open("/proc/kmsg", O_RDONLY | O_NONBLOCK);
>> while(read(fd, buf, sizeof(buf)) > 0);
>> if(errno == EAGAIN) { printf("Clear!\n"); }
>>
>> This is language (spoken-wise) neutral :p
>>
> 
> Gawd, you are a hacker. I already have to suck on pipes
> because I can't seek them. Now, I can't even seek a
> file-system???!!

I'm not sure that seek makes any sense on that, since it is more like a 
pipe than a normal file..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

