Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRJYWBW>; Thu, 25 Oct 2001 18:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276505AbRJYWBJ>; Thu, 25 Oct 2001 18:01:09 -0400
Received: from jalon.able.es ([212.97.163.2]:38031 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276470AbRJYWBA>;
	Thu, 25 Oct 2001 18:01:00 -0400
Date: Thu, 25 Oct 2001 23:48:58 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Omer Sever <omer_sever@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Scheduler and Compilation
Message-ID: <20011025234858.A1550@werewolf.able.es>
In-Reply-To: <007501c15d68$94f12c60$8630fdd4@3232424>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <007501c15d68$94f12c60$8630fdd4@3232424>; from omer_sever@yahoo.com on Thu, Oct 25, 2001 at 17:20:25 +0200
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011025 Omer Sever wrote:
>     I have a project on Linux CPU Scheduler to make it Fair Share
>Scheduler.I will make some changes on some files such as sched.c vs...I will
>want to see the effect ot the change but recompilation of the kernel takes
>about half an hour on my machine.How can I minimize this time?Which part
>should I necessarily include in my config file for the kernel to minimize
>it?
>

Try this (and please tell me if it is worthy or I have to send it to trash)

--- linux-2.4.1-ac14/Makefile.org   Thu Feb 15 15:47:42 2001
+++ linux-2.4.1-ac14/Makefile   Thu Feb 15 15:48:11 2001
@@ -241,6 +241,9 @@
 
 
 include arch/$(ARCH)/Makefile
+
+CC:=$(CC)
+CPP:=$(CPP)
 
 export CPPFLAGS CFLAGS AFLAGS
 

--
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-pre1-beo #1 SMP Thu Oct 25 16:19:19 CEST 2001 i686
