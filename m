Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284056AbRLAKqd>; Sat, 1 Dec 2001 05:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284053AbRLAKqX>; Sat, 1 Dec 2001 05:46:23 -0500
Received: from colorfullife.com ([216.156.138.34]:775 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S284049AbRLAKqG>;
	Sat, 1 Dec 2001 05:46:06 -0500
Message-ID: <000701c17a55$6ec0ea30$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Frank Cornelis" <Frank.Cornelis@rug.ac.be>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ptrace on i386
Date: Sat, 1 Dec 2001 11:46:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> In linux/arch/i386/kernel/ptrace.c next code is being used in the xxxreg
> functions:
> 	if (regno > GS*4)
> 		regno -= 2*4;
> Why this discontinuity? 

Backward compatibility. The syscall entry point changed between 2.0 and 2.2, but
that change must remain invisible to user space apps. the "-= 2*4" converts old offsets
to new offsets (or the other way around)

--
    Manfred

