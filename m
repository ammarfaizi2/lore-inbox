Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272314AbRIKHji>; Tue, 11 Sep 2001 03:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272315AbRIKHj3>; Tue, 11 Sep 2001 03:39:29 -0400
Received: from shaker.worfie.net ([203.8.161.33]:12556 "HELO mail.worfie.net")
	by vger.kernel.org with SMTP id <S272314AbRIKHjN>;
	Tue, 11 Sep 2001 03:39:13 -0400
Date: Tue, 11 Sep 2001 15:39:30 +0800 (WST)
From: "J.Brown (Ender/Amigo)" <ender@enderboi.com>
X-X-Sender: <ender@shaker.worfie.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9ac10 compile failure (hz_to_std)
Message-ID: <Pine.LNX.4.31.0109111538280.5196-100000@shaker.worfie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all.

I'm trying to compile a user-mode version of 2.4.9ac10, but I'm getting a
lot of undefined references to hz_to_std. Was this recently renamed or
something?

gcc -Wl,-T,/usr/src/uml/orig/arch/um/link.ld  -o linux -static \
        /usr/src/uml/orig/arch/um/main.o vmlinux.o -L/usr/lib
vmlinux.o: In function `do_notify_parent':
/usr/src/uml/orig/kernel/signal.c:747: undefined reference to `hz_to_std'
/usr/src/uml/orig/kernel/signal.c:748: undefined reference to `hz_to_std'
vmlinux.o: In function `sys_times':
/usr/src/uml/orig/kernel/sys.c:802: undefined reference to `hz_to_std'
/usr/src/uml/orig/kernel/sys.c:803: undefined reference to `hz_to_std'
/usr/src/uml/orig/kernel/sys.c:804: undefined reference to `hz_to_std'
vmlinux.o:/usr/src/uml/orig/kernel/sys.c:805: more undefined references to
`hz_to_std' follow
collect2: ld returned 1 exit status


TIA :)

 - Ender

Regards,	| If I must have computer systems with publically
	 Ender  | available terminals, the maps they display of my complex
  (James Brown)	| will have a room clearly marked as the Main Control Room.
		| That room will be the Execution Chamber. The actual main
		| control room will be marked as Sewage Overflow Containment.

