Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277605AbRJLJJX>; Fri, 12 Oct 2001 05:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277609AbRJLJJC>; Fri, 12 Oct 2001 05:09:02 -0400
Received: from [195.66.192.167] ([195.66.192.167]:5387 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S277605AbRJLJI7>; Fri, 12 Oct 2001 05:08:59 -0400
Date: Fri, 12 Oct 2001 12:06:22 +0200
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <29988291.20011012120622@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Ability to kill (was: Re: so, no way to kill process? have to reboot?)
In-Reply-To: <3BC6A841.34AEB2BC@loewe-komp.de>
In-Reply-To: <3BC6097F.79B6E2D1@nortelnetworks.com>
 <3BC6A841.34AEB2BC@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PW> Well, I'd suspect it in "D" state - waiting for some disk I/O to
PW> finish...

If a process is stuck in D state it's a kernel bug - I
don't think it's ever legitimate to wait forever for something
which could never happen. However, some such bugs are rarely
happening (e.g. a swapin failure due to hdd malfunction)
and thus will unlikely be fixed.

PW> But in "R" with your described behavior looks like a bug.
PW> If you care about the CPU time waisted: what about kill -STOP <pid>?

R state unkillable hang is possible too (infinite loop in kernel
preventing return from a syscall).

In short, in my understanding any syscall should return sooner
or later in order to process to be killable. Anything preventing
that is a kernel bug.

However, I'm not a UNIX guru, I may be wrong.
I really like to be enlightened if I'm wrong.
-- 
Best regards, vda
mailto:vda@port.imtp.ilyichevsk.odessa.ua


