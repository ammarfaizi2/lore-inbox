Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277300AbRJNUWi>; Sun, 14 Oct 2001 16:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277301AbRJNUW3>; Sun, 14 Oct 2001 16:22:29 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:3344 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S277300AbRJNUWN>; Sun, 14 Oct 2001 16:22:13 -0400
Message-ID: <000b01c154ee$1d6a2610$6400a8c0@it0>
From: "Tommy Faasen" <tommy@vuurwerk.nl>
To: <linux-kernel@vger.kernel.org>
Subject: SMP processor rework help needed
Date: Sun, 14 Oct 2001 22:23:37 +0200
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

Hi,

I have this unique situation where cpu 1 has less features (like fxsr) then
cpu 0.

However the linux kernel only looks at the cpu 0 and assumes the all the
other cpu's have the same capabilities. Which can cause it to oops.
Several of you have been so kind to help me find this problem. Now I can
manually fit it in processor.h to change #define cpu_has_fxsr 0.
I would like to rewrite this bit so it tests all the cpu's if it has a
certain capability and only then activates this feature, I think this would
be a more clean way of handling things.
Anyway I have been looking through processor.h and bitops.h and figured it
does a some asm to extract this information.

So again I am stuck as my limited knowledge stops here, so I was hoping that
someone could give me a helping hand or point me in a direction.

Ps 2.4.12-ac2 works fine with my little modification on my aic78xxx lx smp
system in case you wanted to know.

