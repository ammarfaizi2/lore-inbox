Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265979AbSKBNhK>; Sat, 2 Nov 2002 08:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKBNhK>; Sat, 2 Nov 2002 08:37:10 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:1766 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265979AbSKBNhI>; Sat, 2 Nov 2002 08:37:08 -0500
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
References: <87znsuy9ho.fsf@goat.bogus.local>
	<20021101232758.GB289@elf.ucw.cz>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] 2.5.45: Filesystem capabilities
Date: Sat, 02 Nov 2002 14:43:18 +0100
Message-ID: <87of98ytmx.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> This patch implements filesystem capabilities. It allows to run
>> privileged executables without the need for suid root.
>
> This is gross hack:
>
>> +static char __capname[] = ".capabilities";
>> +
>> +static int __is_capname(const char *name)
>> +{
>> +	if (*name != __capname[0])
>> +		return 0;
>> +
>> +	return !strcmp(name, __capname);
>> +}

Of course, this is a hack. A working hack, btw.

> Yup. Magic filename. With ACLs going in 2.5 and with ext2 support for
> arbitrary metadata, doing capabilities right might be feasible now.

I'm happy to take a look at a working solution.
How come, no one has implemented it yet? :-)

Regards, Olaf.
