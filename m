Return-Path: <linux-kernel-owner+w=401wt.eu-S932715AbWLSJhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWLSJhN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWLSJhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:37:12 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:63110 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbWLSJhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:37:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VXlZTE3U2I5aJa60p2S3ISpn9QN57gtEy8Yli0lrn4H4I3vv83MWQ0WKfiCwKCa4BQcbamCScqKcDnIP3ddxgQoi1DxyULFIpVwQb+KDOfy7KzGKaq6JY3m0JBglxOM5n0m9SkHpptZ6KmnnEViJYF8dl8094ZUBvoeT69w7uzs=
Message-ID: <4587B2C5.9000703@gmail.com>
Date: Tue, 19 Dec 2006 17:37:09 +0800
From: Hawk Xu <hxunix@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Aiee, killing interrupt handler!
References: <200612190205_MC3-1-D591-6D90@compuserve.com>
In-Reply-To: <200612190205_MC3-1-D591-6D90@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>> Our server(running Oracle 10g) is having a kernel panic problem:
>>     
> <> 
>   
>> Process swapper (pid: 0, threadinfo ffffffff80582000, task ffffffff80464300)
>> Stack: 0000000000000296 ffffffff8013f325 ffff81007f7f54d0 0000000000000100
>>        0000000000000001 000000000000000e ffffffff8053e098 ffffffff8013f3a5
>>        ffff81007f7f54d0 ffff810002c10a20
>>     
>
> You need to post the entire oops message, not just the last part.  It should
> start with "BUG". And using a more recent kernel would be a good idea.
>   

I'm sorry, but that's all we have now.  Our customer just sent us a 
photo of the kernel panic screen.

Our customer is running Oracle10g(64bit) and an 32-bit daemon 
application on our server.

Our client also sent the /var/log/kernel file to us.  According to the 
log file, everytime before kernel panic, there are some error messages.  
The server encountered kernel panic three times, below are the error 
messages before each time:

1)
Dec 14 14:00:39 kf85-1 kernel: set_local_var[1886]: segfault at 
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffb358 error 6

2)
Dec 15 10:03:17 kf85-1 kernel: set_local_var[2459]: segfault at 
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffc2e8 error 6
Dec 15 10:36:27 kf85-1 kernel: modeling[12173] trap bounds rip:806aec8 
rsp:ffff9820 error:0
Dec 15 10:51:49 kf85-1 kernel: modeling[14405]: segfault at 
0000000000000008 rip 0000000056b97e8c rsp 00000000ffffaa78 error 6
Dec 15 11:09:14 kf85-1 kernel: set_local_var[20817]: segfault at 
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffc928 error 6
Dec 15 11:16:29 kf85-1 kernel: set_local_var[21760]: segfault at 
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffbd98 error 6
Dec 15 15:10:52 kf85-1 kernel: rtdb_server[17604] trap bounds 
rip:80f5247 rsp:5b9f9040 error:0
Dec 15 15:11:01 kf85-1 kernel: rtdb_server[18631] trap bounds 
rip:80f5247 rsp:58905040 error:0
Dec 15 15:11:16 kf85-1 kernel: rtdb_server[18718] trap bounds 
rip:80f5247 rsp:59300040 error:0
Dec 15 15:11:23 kf85-1 kernel: rtdb_server[18762] trap bounds 
rip:80f5247 rsp:59106040 error:0
Dec 15 15:14:17 kf85-1 kernel: rtdb_server[18869] trap bounds 
rip:80f5247 rsp:5b10a040 error:0
Dec 15 15:14:22 kf85-1 kernel: rtdb_server[19567] trap bounds 
rip:80f5247 rsp:59106040 error:0
Dec 15 15:14:32 kf85-1 kernel: rtdb_server[19586] trap bounds 
rip:80f5247 rsp:57903040 error:0


3)
Dec 15 15:48:30 kf85-1 kernel: set_local_var[2430]: segfault at 
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffc7f8 error 6
Dec 15 16:16:17 kf85-1 kernel: GFileManager[10453]: segfault at 
0000000000003135 rip 00000000574d5f99 rsp 00000000597b3158 error 6


And I didn't figure out why the kernel panic was not in the kernel log file.


Thanks!


hxu
