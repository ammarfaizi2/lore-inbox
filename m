Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVFVHz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVFVHz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVFVHyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:54:35 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:59107 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262791AbVFVHt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 03:49:28 -0400
Message-ID: <002301c57706$486dc630$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "Coywolf Qi Hunt" <coywolf@gmail.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200506220150_MC3-1-A23C-875A@compuserve.com>
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
Date: Wed, 22 Jun 2005 04:41:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW Chuck, this is precisely how OS/2 Warp 3 got page tuned when I was with
IBM Boca many years ago.  The compilers got tweaked to be able to emit
function code to different text sections and a massive system wide code
triage was undertaken based on "common usage scenario" profiling run data
from the perf analysis group.  The results spoke for themselves compared to
the previous 2.X releases - this plan can work and pay off very well.  It
DID worked and paid off very well.


----- Original Message ----- 
From: "Chuck Ebbert" <76306.1226@compuserve.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: <cutaway@bellsouth.net>; "Coywolf Qi Hunt" <coywolf@gmail.com>;
"linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Wednesday, June 22, 2005 01:48
Subject: Re: [RFC] exit_thread() speedups in x86 process.c


>
>   And doing this manually is trivial:
>
>         1. Add two sections to vmlinux.lds.S: .fast.text and .slow.text
>         2. Define __fast __attribute__(__section__(".fast.text"))
>         3. Define __slow similarly
>         4. Start tagging functions with __fast and __slow as needed
>
>   Very little work for much potential gain, AFAICS.
>
>
> --
> Chuck

