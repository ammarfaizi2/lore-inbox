Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289789AbSBNFnf>; Thu, 14 Feb 2002 00:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289775AbSBNFnQ>; Thu, 14 Feb 2002 00:43:16 -0500
Received: from defiant.secureone.com.au ([203.55.158.195]:65190 "EHLO
	defiant.secureone.com.au") by vger.kernel.org with ESMTP
	id <S289762AbSBNFnF>; Thu, 14 Feb 2002 00:43:05 -0500
Posted-Date: Thu, 14 Feb 2002 15:43:34 +1000
X-URL: SecureONE SecureSentry - http://www.secureone.com.au/
Message-ID: <046e01c1b51b$01a50160$0f01000a@brisbane.hatfields.com.au>
Reply-To: "Andrew Hatfield" <lkml@secureone.com.au>
From: "Andrew Hatfield" <lkml@secureone.com.au>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net>
Subject: Re: Linux 2.4.18-pre9-mjc2
Date: Thu, 14 Feb 2002 15:46:53 +1000
Organization: SecureONE
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

got this problem when applying 2.4.18-pre8-mjc to 2.4.18-pre8 to 2.4.17 as
well as newly released 2.4.18-pre8-mjc2

filemap.c: In function `__find_page_nolock':
filemap.c:404: structure has no member named `next_hash'

Not sure if this is related to Rik's rmap patch or Ingo's O(1) Scheduler
patch (or again, something else entirely)

your mjc2 patch contains....
patch-2.4.18-pre9-mjc2:-        struct page *next_hash;         /* Next page
sharing our hash bucket in
patch-2.4.18-pre9-mjc2:-        struct page **pprev_hash;       /*
Complement to *next_hash. */

which modifes linux/include/linux/mm.h


if i comment out the line in filemap.c it continues to compile... until
problems with ip.h (more to come)

  --

  Andrew Hatfield
  SecureONE - http://www.secureone.com.au/
  President - South East Brisbane Linux Users Group  http://www.seblug.org/

  Kernel work available at http://development.secureone.com.au/kernel/


