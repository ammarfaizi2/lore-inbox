Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSLIRNC>; Mon, 9 Dec 2002 12:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbSLIRNB>; Mon, 9 Dec 2002 12:13:01 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:50571 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265791AbSLIRNB> convert rfc822-to-8bit; Mon, 9 Dec 2002 12:13:01 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <ralf@gnu.org>, <willy@debian.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFC1954F5C.20E78677-ONC1256C8A.005E887F@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 9 Dec 2002 18:16:43 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 09/12/2002 18:19:14
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

>Architecture maintainers, can you comment on how easy/hard it is to do the
>same thing on your architectures? I _assume_ it's trivial (akin to the
>three-liner register state change in i386/kernel/signal.c).

For s390/s390x this is actually quite tricky. The system call number is
coded in the instruction, e.g. 0x0aa2 is svc 162 or sys_nanosleep. There
is no register involved that contains the system call number I could
simply change. I either have to change the instruction (no way) or I
have to avoid going back to userspace in this case. This would require
assembler magic in entry.S. Not nice.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


