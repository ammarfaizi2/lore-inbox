Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWJQH1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWJQH1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 03:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWJQH1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 03:27:42 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:20109 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S932191AbWJQH1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 03:27:41 -0400
Message-ID: <453485E9.7010502@dunaweb.hu>
Date: Tue, 17 Oct 2006 09:27:37 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to limit VFAT allocation?
References: <4533598A.3040909@dunaweb.hu> <200610161225.33190.prakash@punnoor.de> <4533658A.5030105@dunaweb.hu> <4533BD1E.3080804@lsrfire.ath.cx>
In-Reply-To: <4533BD1E.3080804@lsrfire.ath.cx>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe írta:
> Zoltan Boszormenyi schrieb:
>   
>> Prakash Punnoor írta:
>>     
>>> Am Montag 16 Oktober 2006 12:06 schrieb Zoltan Boszormenyi:
>>>  
>>>       
>>>> Is there a way to tell the VFAT driver to exclude
>>>> the last N sectors from the allocation strategy?
>>>>     
>>>>         
>>> Can't you mark that clusters as bad with a diskeditor?
>>>   
>>>       
>> Can you suggest one that works on Linux?
>> Or which bits should I change if I use LDE?
>> (lde.sourceforge.net)
>>     
>
> Try mbadblocks, part of the Mtools package (http://mtools.linux.lu/).
> If it doesn't help, and you are brave, you may want to play with
> mdoctorfat, which comes with Mtools, too, but is hidden for some reason. :->
>
> René
>   

Thanks. I have set up my /root/.mtoolsrc and:

# mbadblocks x:
plain_io: Input/output error
Bad cluster 63985 found
plain_io: Input/output error
Bad cluster 63986 found
plain_io: Input/output error
Bad cluster 63987 found
plain_io: Input/output error
Bad cluster 63988 found
plain_io: Input/output error
Bad cluster 63989 found

After unplugging the device didn't reformat itself.
Filling the disk seems to be working. It gives me
"disk full" without any new "Buffer I/O error on device sdc1"
or FAT panic messages in the kernel logs.

Thanks and best regards,
Zoltán Böszörményi

