Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280657AbRKNPiu>; Wed, 14 Nov 2001 10:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280656AbRKNPiH>; Wed, 14 Nov 2001 10:38:07 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:47523 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S280655AbRKNPgT>; Wed, 14 Nov 2001 10:36:19 -0500
Message-ID: <3BF28F6C.90008@sap.com>
Date: Wed, 14 Nov 2001 16:36:12 +0100
From: Willi =?ISO-8859-1?Q?N=FC=DFer?= <wilhelm.nuesser@sap.com>
Organization: SAP AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Comparison of PAE and Non-PAE 2..4.14 (p8) in high load
In-Reply-To: <3BF27557.30007@sap.com> <3BF2837B.4B63FBA5@didntduck.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

 
>>
>>Results:
>>---------
>>
>>2.4.7
>>        2.4.14p8 PAE            2.4.14p4 non- PAE
>>-------------------------------------------------------------
>>   1.80         13.42                   15.47
>>   1.10         13.28                   14.76
>>   1.20                 14.08                   14.63
>>   1.26         13.17                   15.30
>>   1.35         13.41                   14.51
>>
>>This means that we did see a performance decrease of about
>>6 % compared to 2.4.14p8 nonPAE but still 2.4.14p8 is an order
>>of magnitude faster than 2.4.7
>>
> 
> PAE mode increases the size of the page table entries to 64-bits, and
> the x86 doesn't do 64-bit operations very well.  Plus it has three 

> levels of tables to work with instead of two.  


Yes, I know the difference. The reason for this post was not blind
curiosity but the presumption that the great performance increase of 
2.4.14p8 we reported was mainly due to the PAE enabling in the 2.4.7 and 
non-PAE-enabling 2.4.14p8 in our first test.

The tests above show that this is not the case. Even with PAE 2.4.14 is
faster by an order of magnitude.

The other info we did find interesting is the actual amount of 
difference between PAE and nonPAE. The 6% we got fit very well in some
estimates I found on lkml.

-- 
Best regards
Willi

-----------------------------------
Willi Nuesser
SAP Linuxlab

