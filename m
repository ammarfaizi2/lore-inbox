Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSDPImp>; Tue, 16 Apr 2002 04:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313639AbSDPImo>; Tue, 16 Apr 2002 04:42:44 -0400
Received: from wiproecmx2.wipro.com ([164.164.31.6]:48543 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S313637AbSDPImn>; Tue, 16 Apr 2002 04:42:43 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "William Lee Irwin III" <wli@holomorphy.com>,
        "Olaf Fraczyk" <olaf@navi.pl>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Why HZ on i386 is 100 ?
Date: Tue, 16 Apr 2002 13:48:56 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBEEONCEAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-088d43fa-5105-11d6-a942-00b0d0d06be8"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020416081453.GP21206@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-088d43fa-5105-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

I remember seeing somewhere unix system VII used to have HZ set to 60
for the machines built in the 70's. I wonder if todays pentium iiis and ivs
should still use HZ of 100, though their internal clock is in GHz. 

I think somethings in the kernel may be tuned for the value of HZ, these
things would be arch specific.

Increasing the HZ on your system should change the scheduling behaviour,
it could lead to more aggresive scheduling and could affect the
behaviour of the VM subsystem if scheduling happens more frequently. I am
just guessing, I do not know.

Changing though trivial would require a good look at all the code that
uses HZ.

Comments,
Balbir

|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org
|[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of William Lee
|Irwin III
|Sent: Tuesday, April 16, 2002 1:45 PM
|To: Olaf Fraczyk
|Cc: linux-kernel@vger.kernel.org
|Subject: Re: Why HZ on i386 is 100 ?
|
|
|On Tue, Apr 16, 2002 at 09:47:48AM +0200, Olaf Fraczyk wrote:
|> Hi,
|> I would like to know why exactly this value was choosen.
|> Is it safe to change it to eg. 1024? Will it break anything?
|> What else should I change to get it working:
|> CLOCKS_PER_SEC?
|> Please CC me.
|> Regards,
|> Olaf Fraczyk
|
|I tried a few times running with HZ == 1024 for some testing (or I guess
|just to see what happened). I didn't see any problems, even without the
|obscure CLOCKS_PER_SEC ELF business.
|
|
|Cheers,
|Bill
|-
|To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
|Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPartTM-000-088d43fa-5105-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************
      


Information contained in this E-MAIL being proprietary to Wipro Limited
is 'privileged' and 'confidential' and intended for use only by the
individual or entity to which it is addressed. You are notified that any
use, copying or dissemination of the information contained in the E-MAIL
in any manner whatsoever is strictly prohibited.



 ********************************************************************

------=_NextPartTM-000-088d43fa-5105-11d6-a942-00b0d0d06be8--
