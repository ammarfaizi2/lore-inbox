Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284041AbRLAKRw>; Sat, 1 Dec 2001 05:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284043AbRLAKRn>; Sat, 1 Dec 2001 05:17:43 -0500
Received: from dobit2.rug.ac.be ([157.193.42.8]:896 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S284041AbRLAKR1>;
	Sat, 1 Dec 2001 05:17:27 -0500
Date: Sat, 1 Dec 2001 11:17:24 +0100 (MET)
From: Frank Cornelis <Frank.Cornelis@rug.ac.be>
To: <linux-kernel@vger.kernel.org>
cc: <Frank.Cornelis@rug.ac.be>
Subject: ptrace on i386
Message-ID: <Pine.GSO.4.31.0112011106410.4313-100000@eduserv.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In linux/arch/i386/kernel/ptrace.c next code is being used in the xxxreg
functions:
	if (regno > GS*4)
		regno -= 2*4;
Why this discontinuity? It doesn't prevent ORIG_EAX and EIP from being
written and makes the defines CS, EIF, ... from linux/include/asm/ptrace.h
useless. BTW: regno should really call reg_offset since it's no register
number but an offset.

Please CC me,

Frank.

