Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSFDSYp>; Tue, 4 Jun 2002 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSFDSYp>; Tue, 4 Jun 2002 14:24:45 -0400
Received: from relay.trecorp.com ([64.71.177.139]:21764 "HELO
	tre.bloodletting.com") by vger.kernel.org with SMTP
	id <S316182AbSFDSYn>; Tue, 4 Jun 2002 14:24:43 -0400
Message-ID: <153.25.1023215073895@tre.bloodletting.com>
Date: Tue, 4 Jun 2002 11:24:33 -0700
From: Nick Popoff <lkml@tre.bloodletting.com>
Subject: Question regarding do_munmap
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
Greetings all.  My apologies in advance if this question is off topic 
for this list.  I'm responsible for Linux drivers for the hardware my 
company makes.  Our drivers use kernel modules which use the 
do_munmap() function.  I noticed that the kernel provided in RH 7.3 is 
patched to change this function to add a new parameter which is 
missing in the generic kernel. 
 
(Generic 2.4.18 include/linux/mm.h) 
extern int do_munmap(struct mm_struct *, unsigned long, size_t); 
 
(RH 7.3/AC patched 2.4.18-3 include/linux/mm.h) 
extern int do_munmap(struct mm_struct *, unsigned long, size_t, int 
acct); 
 
My question is what is the recommended way for module developers to 
handle changes to this API so that end users don't have to edit 
makefiles to build for their particular kernel?  Is there a way to 
detect that a specific patch or patch author is in use so that my 
install script can use the correct function?  Any recomendations on 
how to handle this besides grep'ing source in my installer? :-) 
 
Any advice on this would be much appreciated.  Right now our driver is 
easier to install on Linux than another other OS we support and I want 
to keep it that way!  Also, I'm not subscribed to this fearsome 
mailing list so please CC me on any replies. 
 
 
 
