Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132529AbRDDXq0>; Wed, 4 Apr 2001 19:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132531AbRDDXqQ>; Wed, 4 Apr 2001 19:46:16 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:20675 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S132529AbRDDXqD>; Wed, 4 Apr 2001 19:46:03 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880A07@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: vmalloc on 2.4.x on ia64
Date: Wed, 4 Apr 2001 17:44:25 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can we call vmalloc() or get_free_pages() from scsi low-level driver 
(HBA driver) ? The reason why I am asking is because, I am calling
vmalloc from scsi low-level driver and I tried this on 2.4.2 on
ia32 as well as ia64 and on both the systems, it is hanging.
on ia64 it happens everytime whereas on ia32 it happens intermittently. 
In case of ia32, I had watchdog enabled. So, on ia32, it detects LOCKUP
and generates call trace. I am yet to try get_free_pages().

TIA,
-hiren

> -----Original Message-----
> From: Matt_Domsch@Dell.com [mailto:Matt_Domsch@Dell.com]
> Sent: Monday, April 02, 2001 6:30 PM
> To: hiren_mehta@agilent.com
> Subject: RE: vmalloc on 2.4.x on ia64
> 
> 
> > That is what I said. I am using vmalloc only. But the call to
> > vmalloc is hanging.
> 
> Oops, my mistake.  a) that shouldn't happen.  b) if it does, try
> get_free_pages().
> 
