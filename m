Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWIRT5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWIRT5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWIRT5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:57:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:40680 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751898AbWIRT5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:57:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ElfUUt2QkKgqQD2DcpfCSKjaeGp29Cdhh0ivif7o1eFNqkTWfxjGyBVJJRLaqD8Xh0240/G4AxaSZQIP/LPBk3RW4pFigQUKyX4I74tjyMbIXNR+4jOwwQmDL03YVwW3WEysGnIAsenvjHfqXCiBZg5mFFPugIyEYvhevu/Zdrc=
Message-ID: <450EFA4C.1070004@gmail.com>
Date: Mon, 18 Sep 2006 23:58:04 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Eugeny S. Mints" <eugeny.mints@gmail.com>,
       pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
References: <45096933.4070405@gmail.com> <20060918104437.GA4973@elf.ucw.cz> <450E83DC.4050503@gmail.com>
In-Reply-To: <450E83DC.4050503@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeny S. Mints wrote:
> Pavel Machek wrote:
>> Hi!
>>
[skip]
>> How is it going to work on 8cpu box? will
>> you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?

basically I guess you are asking about what the names of operating points are 
and how to distinguish between operating points from userspace on 8cpu box.

An advantage of PowerOP approach is that operating point name is used as a 
_handle_ and may or may not be meaningful. The idea is that if a policy manager 
  needs to make a decision and needs to distinguish between operating points it 
can check value of any power parameters of operating points in question. Power 
parameter values may be obtained under <op_name> dir name.

With such approach a policy manger may compare operating points at runtime and 
should not rely on compile time knowledge about what name corresponds to  what 
set of power parameter values. It uses name as a handle.

	Eugeny
> 
> i do not operate with term 'state' so I don't understand what it means 
> here.
> 
>     Eugeny
> 
>>                                 Pavel
> 
> 

