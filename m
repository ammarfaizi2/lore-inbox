Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267298AbSKPPqR>; Sat, 16 Nov 2002 10:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbSKPPqR>; Sat, 16 Nov 2002 10:46:17 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:59556 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267298AbSKPPqQ>; Sat, 16 Nov 2002 10:46:16 -0500
Cc: linux-kernel@vger.kernel.org
References: <BA5F894454FFF542A3C0B3F41024D8BD244A93@mailse02.axis.se>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: Re: [PATCH] 2.5.47: strdup()
Date: Sat, 16 Nov 2002 16:53:00 +0100
In-Reply-To: <BA5F894454FFF542A3C0B3F41024D8BD244A93@mailse02.axis.se> (Peter
 Kjellerstedt's message of "Sat, 16 Nov 2002 09:48:57 +0100")
Message-ID: <87n0o9340z.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Kjellerstedt <peter.kjellerstedt@axis.com> writes:

>> +char *strdup(const char *s)
>> +{
>> +	char *p = kmalloc(strlen(s) + 1, GFP_KERNEL);
>> +	if (p)
>> +		strcpy(p, s);
>> +
>> +	return p;
>>  }
>>  #endif
>
> You should make sure s != NULL before doing anything else.

Like strcpy(), it's the caller's responsibility to provide a valid
pointer. This shouldn't be a problem however, since access to NULL
triggers an Oops and thus is quickly detected.

Regards, Olaf.
