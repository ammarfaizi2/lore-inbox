Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRAOR1T>; Mon, 15 Jan 2001 12:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRAOR1J>; Mon, 15 Jan 2001 12:27:09 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:20219 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129733AbRAOR0z>; Mon, 15 Jan 2001 12:26:55 -0500
From: Christoph Rohland <cr@sap.com>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] memparse should return long long
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF19@orsmsx31.jf.intel.com>
Organisation: SAP LinuxLab
Date: 15 Jan 2001 18:25:06 +0100
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF19@orsmsx31.jf.intel.com>
Message-ID: <qwwlmsciv7x.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, 15 Jan 2001, Randy Dunlap wrote:
> Why not (?):

Because I did not need it (always used #G or #M) and did not know the
function. But it's apparently correct to use simple_strtoull.

>> diff -uNr 2.4.0-ac/lib/cmdline.c 2.4.0-ac-memparse/lib/cmdline.c
>> --- 2.4.0-ac/lib/cmdline.c	Mon Aug 28 11:42:45 2000
>> +++ 2.4.0-ac-memparse/lib/cmdline.c	Mon Jan 15 09:06:14 2001
>> @@ -93,9 +93,9 @@
>>   *	megabyte, or one gigabyte, respectively.
>>   */
>>  
>> -unsigned long memparse (char *ptr, char **retptr)
>> +unsigned long long memparse (char *ptr, char **retptr)
>>  {
>> -	unsigned long ret = simple_strtoul (ptr, retptr, 0);
>> +	unsigned long long ret = simple_strtoul (ptr, retptr, 0);
> ! +	unsigned long long ret = simple_strtoull (ptr, retptr, 0);
> 
> ~Randy

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
