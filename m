Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWHASOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWHASOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWHASOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:14:46 -0400
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:44243 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1751745AbWHASOp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:14:45 -0400
Message-ID: <44CF9A64.7070204@kolumbus.fi>
Date: Tue, 01 Aug 2006 21:16:04 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/33] i386: Relocatable kernel support.
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>	<11544302351934-git-send-email-ebiederm@xmission.com>	<44CF5850.80906@kolumbus.fi> <m1y7u8xrcp.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y7u8xrcp.fsf@ebiederm.dsl.xmission.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2 HF462|May 23, 2006) at 01.08.2006 21:14:41,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 01.08.2006 21:14:42,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 01.08.2006 21:14:42,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 01.08.2006 21:14:43,
	Serialize complete at 01.08.2006 21:14:43
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Mika Penttilä <mika.penttila@kolumbus.fi> writes:
>
>   
>>> @@ -1,9 +1,10 @@
>>>  SECTIONS
>>>  {
>>> -  .data : { +  .data.compressed : {
>>>  	input_len = .;
>>>  	LONG(input_data_end - input_data) input_data = .;  	*(.data)
>>> +	output_len = . - 4;
>>>  	input_data_end = .;  	}
>>>  }
>>>
>>>       
>> I don't see how you are getting the uncompressed length from output_len...
>>     
>
> It's part of the gzip format.  It places the length at the end of
> the compressed data.  I am just computing the address of where gzip
> put the length and putting a variable there called output_len.
>
> Isn't linker script magic wonderful :)
>
> Eric
> -
>   
Huh, quite a nice trick indeed!

Thanks,
Mika

