Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262642AbSI0W5a>; Fri, 27 Sep 2002 18:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262643AbSI0W5a>; Fri, 27 Sep 2002 18:57:30 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:18891 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262642AbSI0W53>; Fri, 27 Sep 2002 18:57:29 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] accessfs v0.6 ported to 2.5.35-lsm1 - 1/2
References: <878z1rpfb4.fsf@goat.bogus.local>
	<20020926203716.GA7048@kroah.com> <87adm3i7nr.fsf@goat.bogus.local>
	<20020927214642.GS12909@kroah.com>
From: Olaf Dietsche 
	<olaf.dietsche--list.linux-security-module@exmail.de>
Date: Sat, 28 Sep 2002 01:02:33 +0200
Message-ID: <87hegb594m.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Fri, Sep 27, 2002 at 08:55:52PM +0200, Olaf Dietsche wrote:
>>  
>> +static int cap_ip_prot_sock (int port)
>> +{
>> +	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
>> +		return -EACCES;
>> +
>> +	return 0;
>> +}
>> +
>
> Do we really want to force all of the security modules to implement this
> logic (yes, it's the same discussion again...)

I don't understand what you mean. There must be _some_ implementation
for this hook. Of course, everybody's free to do his own.

Regards, Olaf.
