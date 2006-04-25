Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWDYRUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWDYRUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWDYRUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:20:05 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:58629 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751181AbWDYRUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:20:04 -0400
Message-ID: <444E5A3E.1020302@argo.co.il>
Date: Tue, 25 Apr 2006 20:19:58 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>	 <1145911546.1635.54.camel@localhost.localdomain>	 <444D3D32.1010104@argo.co.il>	 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>	 <444DCAD2.4050906@argo.co.il>	 <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>	 <444E524A.10906@argo.co.il> <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com>
In-Reply-To: <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 17:20:02.0639 (UTC) FILETIME=[7CDFCDF0:01C6688C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
>>>     TakeLock l(&lock);
>>>
>>>     do_something();
>>>     do_something_else();
>>>
>>> First of all, that extra TakeLock object chews up stack, at least 4 or
>>> 8 bytes of it, depending on your word size.
>>>       
>> No, it's optimized out. gcc notices that &lock doesn't change and that
>> 'l' never escapes the function.
>>     
>
> "l" that propects critical section gets thrown away??? 
Calm down, the storage for 'l' is thrown away, but its effects remain.
> What is the
> name of the filesystem you ported? I mean, I need to know so I don't
> use it by accident.
>   
It's very expensive, you can't use it by accident.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

