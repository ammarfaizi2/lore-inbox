Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKIRQC>; Thu, 9 Nov 2000 12:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbQKIRPw>; Thu, 9 Nov 2000 12:15:52 -0500
Received: from smarty.smart.net ([207.176.80.102]:19482 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S129103AbQKIRPj>;
	Thu, 9 Nov 2000 12:15:39 -0500
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200011091715.MAA24229@smarty.smart.net>
Subject: Incorrectness for fun and profit
To: linux-kernel@vger.kernel.org
Date: Thu, 9 Nov 100 12:15:19 -0500 (EST)
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4 init/main.c we have...

 * Versions of gcc older than that listed below may actually compile
 * and link okay, but the end product can have subtle run time bugs.
 * To avoid associated bogus bug reports, we flatly refuse to compile
 * with a gcc that is known to be too old from the very beginning.
 */
#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 1)
#error Sorry, your GCC is too old. It builds incorrect kernels.
#endif

Note that I've elided the 9 from the minor version number. I also tweaked
the #define asmlinkage in whereveritis.h to look a bit more like 2.2, got
rid of the arch=bla switch to gcc, and built the kernel I'm using at the
moment with gcc 2.7.2.3. I'm looking for "subtle run time bugs". OK, I'm
desparate for entertainment. That's a given. Where should I look?
Everything I'm cognizant of so far is real pretty. I WANT BUGS! WHERE ARE
THE BUGS?

This is not a bogus bug report. This is a repeatable bug request.


Incorrectly yours,

Rick Hohensee
:; cLIeNUX0 /dev/tty12  12:43:36   /
:;get /Linux/version
Linux version 2.4.0-test10 (@cLIeNUX) (gcc version 2.7.2.3) #10 Thu Nov 9
03:11:45 2000
:; cLIeNUX0 /dev/tty12  13:03:02   /
:;




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
