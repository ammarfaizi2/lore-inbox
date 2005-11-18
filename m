Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbVKRUln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbVKRUln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbVKRUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:41:43 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:16403 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1161194AbVKRUll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:41:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <437E3617.8000207@superbug.demon.co.uk>
References: <7EC22963812B4F40AE780CF2F140AFE920904A@IN01WEMBX1.internal.synopsys.com> <437E3617.8000207@superbug.demon.co.uk>
X-OriginalArrivalTime: 18 Nov 2005 20:41:40.0107 (UTC) FILETIME=[7A426DB0:01C5EC80]
Content-class: urn:content-classes:message
Subject: Re: Does Linux has File Stream mapping support...?
Date: Fri, 18 Nov 2005 15:41:39 -0500
Message-ID: <Pine.LNX.4.61.0511181530010.10758@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Does Linux has File Stream mapping support...?
Thread-Index: AcXsgHpJboExxuTMTTKNdHghwSqbVw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Cc: "Arijit Das" <Arijit.Das@synopsys.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Nov 2005, James Courtier-Dutton wrote:

> Arijit Das wrote:
>> Is it possible to have File Stream Mapping in Linux? What I mean is
>> this...
>>
>> FILE * fp1 = fopen("/foo", "w");
>> FILE * fp2 = fopen("/bar", "w");
>> FILE * fp_common = <Stream_Mapping_Func>(fp1, fp2);
>>
>> fprint(fp_common, "This should be written to both files ... /foo and
>> /bar");
>>
>> So, what I am looking for is anything written to "fp_common" should
>> actually be written to the streams fp1 and fp2.
>>
>> Does Linux support this any way? Is there any way to achieve this...? Is
>> there anything like <Stream_Mapping_Func>(above) ...?
>>
>> Do pardon me if you feel that it is a wrong Forum to ask this question
>> but I tried everywhere else and thought that implementers would best
>> know about it, if at all anything like that exists.
>>
>> Thanks,
>> Arijit
>> -
>
> Why not just output to a file, and then use "tail -f filename"

I just did a 'google' to see if anybody had such a function.
It looks like he's going to have to write his own because there
isn't anything like that yet.

I don't know what you'd use it for because it's easy to
make two or more...
 	fputs(buffer, file1);
 	fputs(buffer, file2);
 	fputs(buffer, file3);
...etc.

Also, if he's using terminal I/O scripts, he should investigate
`tee`.

Maybe he thinks that stuff would get written simultaneously if
there were any such function!

Arijit, computers can't walk and chew gum at the same time.
Nothing gets written simultaneously! Just chose the order at
which you would like to have buffered I/O occur and, except
for 'stderr' even that order isn't guaranteed!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
