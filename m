Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSEMH4i>; Mon, 13 May 2002 03:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315865AbSEMH4h>; Mon, 13 May 2002 03:56:37 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:33525 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S315862AbSEMH4h> convert rfc822-to-8bit; Mon, 13 May 2002 03:56:37 -0400
Importance: Normal
Sensitivity: 
Subject: Re: Strange s390 code in 2.4.19-pre8
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFFA479633.3A335CB7-ONC1256BB8.002ABB8D@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 13 May 2002 09:54:59 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 13/05/2002 09:56:23
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,
> I reviewed the -pre8 briefly, and is seems that the vast
> majority of s390/s390x changes are good, but I cannot discern
> the intent of some of them. I would like Martin or Ulrich
> to comment.
Ahh, its great that someone is doing reviews of our code.

> #1 - smp_call_function in a driver, trying to be ultra smart
> or IBM's hardware is too broken and asymmetric?
The iucv stuff in VM is a bit asymmetric ...

> #2 - strange changes to net Makefile
The intention of this is to have fsm.o built as a module if ctc
and iucv are built as modules too. I agree that this is broken
if one of {iucv,ctc} is built as a module and the other is built
in.

> #3 - config.in patch inconsistent or deadwood
> This is wonderful, but why did you merge it to Marcelo if the
> rest of the code is missing?
The rest is missing because we are waiting for the legal ok.
That the config.in contains these two lines is a mistake of mine.

> And, while we are on topic, when are you guys going to merge
> changes to the partitioning code?
I sent the patch together with the lcs driver to Marcelo last
week but I haven't heard of him yet. Wait and see ?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


