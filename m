Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRLBOdX>; Sun, 2 Dec 2001 09:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279603AbRLBOdN>; Sun, 2 Dec 2001 09:33:13 -0500
Received: from extasia.u-strasbg.fr ([130.79.90.105]:776 "EHLO
	extasia.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S279581AbRLBOdG>; Sun, 2 Dec 2001 09:33:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Blindauer Emmanuel <manu@agat.net>
Reply-To: manu@agat.net
Organization: AGAT . NET
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: what happened with thread, from 2.2 to 2.4 ?!
Date: Sun, 2 Dec 2001 15:33:43 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01120215334302.00742@extasia>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
what happenned with thread from 2.2 to 2.4?
I have some problems with threaded programs, working under 2.2 and no more 
under 2.4
The test program is short:
----
#include <stdlib.h>
void main() {
  char *t="1.0";
  double d=0;
  d=strtod(t,(char **)NULL);
}
---
this program compiled with "gcc -g -lpthread test.c" has strange behaviour. 
The problem only appear using gdb to see the value of d
In most case, the value returned by strtod under a 2.4 kernel is nan.
I say most, because some 2.4 kernels don't fail other this line.
I have done some test with differents distributions, and so differents 
version of kernel, gcc, gdb and libc.
http://manu.agat.net/bug.html

When it was possible, for the computer with the bug, under an 2.4 kernel, 
I've recompiled a 2.2.20, and the bug has disappeared!

Does someone have an idea about that ?
