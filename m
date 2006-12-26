Return-Path: <linux-kernel-owner+w=401wt.eu-S932255AbWLZEx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWLZEx7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 23:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWLZEx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 23:53:59 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:63305 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbWLZEx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 23:53:58 -0500
Message-ID: <4590AADD.2070304@bx.jp.nec.com>
Date: Tue, 26 Dec 2006 13:53:49 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH -mm 3/5] add interface for netconsole using sysfs
References: <458BC905.7050003@bx.jp.nec.com>	<458BCC2C.9070802@bx.jp.nec.com> <20061223213426.aa80907e.randy.dunlap@oracle.com>
In-Reply-To: <20061223213426.aa80907e.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your replies and reviews.

I will follow your advices.

>>  static LIST_HEAD(target_list);
>>  
>>  static DEFINE_SPINLOCK(target_list_lock);
>>  
>> +static ssize_t show_local_ip(struct netconsole_target *nt, char *buf)
>> +{
>> +	return sprintf(buf, "%d.%d.%d.%d\n", HIPQUAD(nt->np.local_ip));
> 
> I don't understand the use of HIPQUAD() here instead of
> NIPQUAD().  Explain?
> 
> Also, NIPQUAD_FMT (in kernel.h) uses "%u.%u.%u.%u".
> This should probably be the same.
> Or just use:	NIPQUAD_FMT "\n"

IP address is stored in the form of host byte order in netpoll structure.
So, You can't use NIPQUAD to follow the current implementation of netpoll.

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com


