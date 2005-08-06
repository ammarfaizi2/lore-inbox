Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263223AbVHFPtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263223AbVHFPtC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 11:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbVHFPtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 11:49:02 -0400
Received: from web60521.mail.yahoo.com ([209.73.178.169]:17776 "HELO
	web60521.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263223AbVHFPtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 11:49:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MunLBJx2kRjOZo7M4Nq+brEAFI6q8GA/O6jGy7Mdjap5huHcLMPvdIud3S+iFJS/S+oV38z2lUXvrnja97RfGmaDqLPTHfvVoPtNxEu4MtfWgSFN5zwI5FJm4qBQsGfNZife6T+D861oT/Ra0fr7w7Q25v9zV0rujzE2uOzxieY=  ;
Message-ID: <20050806154901.97385.qmail@web60521.mail.yahoo.com>
Date: Sat, 6 Aug 2005 08:49:00 -0700 (PDT)
From: mhb <badrpayam@yahoo.com>
Subject: a question?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I had added an assembly program to the networking
section of kernel linux 2.2.16 without any problem.
But when I add it to kerenel 2.4.1 I could build that
kernel, but I faced with kernel panic error when I
boot
system with new builded image. I use the following
Make file to build It in the 2.4.1 kernel. 

/*--------------------------------*/
L_TARGET := libtest.a

obj-$(CONFIG_TEST)		+= test.o

override CFLAGS += -Wpointer-arith
override CFLAGS += -Wbad-function-cast
override CFLAGS += -DTERMIO


#-----------------------------------------------------------------------------
# Section 3 - Conversion routines from new style to
old style for Rules.make

#-----------------------------------------------------------------------------
# Section 4 - Rules.make section
include $(TOPDIR)/Rules.make
#-----------------------------------------------------------------------------
# Section 5

$(obj-y):  $(TOPDIR)/include/linux/config.h\
                       
$(TOPDIR)/include/linux/autoconf.h

clean:
	-rm -f *.o
tags:
	ctags libtest.a

tar:
	tar -cvf /dev/f1 .

test.o: test1.o test2.o test3.o 
	$(LD) -r -o $@ test1.o test2.o test3.o 

test3.o: test3.s
	$(AS) -o $@ $<
#-----------------------------------------------------------------------------
As you can see test3.s is an assembly file.
I guess this problem is related to this Makefile.
Is this Make file true?
How can I win over this problem?

thanks

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
