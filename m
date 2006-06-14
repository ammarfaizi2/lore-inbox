Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWFNIee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWFNIee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 04:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWFNIee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 04:34:34 -0400
Received: from mx-3.csfb.com ([198.240.130.80]:63195 "EHLO ny-bas07.csfb.com")
	by vger.kernel.org with ESMTP id S1751180AbWFNIed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 04:34:33 -0400
X-Server-Uuid: 6BE1D2C2-03E1-4EE2-8B18-93F153C930CE
Message-ID: <F444CAE5E62A714C9F45AA292785BED30EB971C4@esng11p33001.sg.csfb.com>
From: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: binary portability
Date: Wed, 14 Jun 2006 16:34:16 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
X-WSS-ID: 68911584104139467-01-03
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the clarifications. Just had 1 more question. Can I port binaries built on RHEL 3/Opteron(2.4.21) to SLES 9/Opteron (2.6.5-7.252) and run without any issues?  

Thanks

Rajib

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: 08 June 2006 22:51
To: Jan Engelhardt
Cc: Majumder, Rajib; 'linux-kernel@vger.kernel.org'
Subject: Re: binary portability


Ar Iau, 2006-06-08 am 12:42 +0200, ysgrifennodd Jan Engelhardt:
> >I know that EM64T and AMD64 are ISA compatible, but there could be some 
> >differences in ELF32 between these 2 processor architectures. 
> >
> What differences? (Apart from MMXEXT and SSE2,SSE3)

There are multiple ISA differences that affect ring 0 (kernel code), but
only one nasty that hit user code with early Intel clones. The early
Intel clones didn't implement the prefetch instructions that are
mandatory in x86-64. This broke a few apps early on but they got
workarounds very fast.

If the code is built for the generic instruction set (as is the case
unless you try very hard) then it should be perfect on both.

Alan


==============================================================================
Please access the attached hyperlink for an important electronic communications disclaimer: 

http://www.credit-suisse.com/legal/en/disclaimer_email_ib.html
==============================================================================

