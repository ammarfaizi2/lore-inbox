Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132024AbQLZUmW>; Tue, 26 Dec 2000 15:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132026AbQLZUmM>; Tue, 26 Dec 2000 15:42:12 -0500
Received: from jalon.able.es ([212.97.163.2]:49570 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132024AbQLZUl7>;
	Tue, 26 Dec 2000 15:41:59 -0500
Date: Tue, 26 Dec 2000 21:11:14 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: CCFOUND and more
Message-ID: <20001226211114.A1511@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

Solving other things, I have realized that all that problem on fast
CC detection (CCFOUND) is easily solved by doing:
	CC  := $(.................)
instead of
	CC = $(.........)
The find of the suitable CC command is repeated many times along a 
kernel build. And CC is not anything that can change along a kernel
build. So former syntax solves all the problems, CC detection can
be so complex as you want because is done only once.

Same is valid for other Makefile variables:
CPP = $(CC) -E ===> CPP := $(CC) -E

(If you want to test how many shells are spawned when using CC, try
CC  = $(shell echo "===== CC EVAL ===============" >&2; if ........
vs
CC  := $(shell echo "===== CC EVAL ===============" >&2; if .......

Is there something I am missing ?

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre3-aa2 #9 SMP Tue Dec 26 12:26:43 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
