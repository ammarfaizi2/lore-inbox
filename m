Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268824AbUHLWMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268824AbUHLWMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268788AbUHLWMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:12:00 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:6020 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268842AbUHLWLt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:11:49 -0400
Message-ID: <411BEBF5.6050102@tmr.com>
Date: Thu, 12 Aug 2004 18:15:17 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <1092082920.5761.266.camel@cube> <cone.1092092365.461905.29067.502@pc.kolivas.org>
In-Reply-To: <cone.1092092365.461905.29067.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Albert Cahalan writes:
> 
> 
>> Joerg:
>>    "WARNING: Cannot do mlockall(2).\n"
>>    "WARNING: This causes a high risk for buffer underruns.\n"
>> Fixed:
>>    "Warning: You don't have permission to lock memory.\n"
>>    "         If the computer is not idle, the CD may be ruined.\n"
>>
>> Joerg:
>>    "WARNING: Cannot set priority class parameters 
>> priocntl(PC_SETPARMS)\n"
>>    "WARNING: This causes a high risk for buffer underruns.\n"
>> Fixed:
>>    "Warning: You don't have permission to hog the CPU.\n"
>>    "         If the computer is not idle, the CD may be ruined.\n"
> 
> 
> Huh? That can't be right. Every cd burner this side of the 21st century 
> has buffer underrun protection. I've burnt cds _while_ capturing and 
> encoding video using truckloads of cpu and I/O without superuser 
> privileges, had all the cdrecord warnings and didn't have a buffer 
> underrun. Last time I gave superuser privilege to cdrecord it locked my 
> machine - clearly it wasn't rt_task safe.

This may be a side effect of your scheduler, then. Cdrecord is run as or 
by root on a lot of systems and I've never had any indication that ever 
does anything which hurts response, other than to lock down a small 
memory section for fifo.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
