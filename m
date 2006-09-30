Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422884AbWI3B5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbWI3B5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 21:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422886AbWI3B5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 21:57:04 -0400
Received: from web52812.mail.yahoo.com ([206.190.49.1]:16302 "HELO
	web52812.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1422882AbWI3B5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 21:57:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XeLZLhIagQKgeQweuMpBv8FCfsH7cJmZavrRLBOKiZsNUKL1Enq9dUvCsw9jUBcEpkPOO3w0iJCGuBpBy7McP+XgnbN0kheXj1QvUN/tgf4FdTPK2v/EZZnCPnWy9imza7Izh7GFlEhhLQtfsYe7Z1bJhZRlsW7llfZfJrsfNtY=  ;
Message-ID: <20060930015700.26045.qmail@web52812.mail.yahoo.com>
Date: Fri, 29 Sep 2006 18:57:00 -0700 (PDT)
From: x z <dealup@yahoo.com>
Subject: Makefile for linux modules
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060929182008.fee2a229.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
   I have a makefielt to make several driver modules:
obj-$(CONFIG_FUSION_SPI)	+= mptbase.o mptscsih.o
mptspi.o
obj-$(CONFIG_FUSION_FC)		+= mptbase.o mptscsih.o
mptfc.o
obj-m				+= mptbase.o mptscsih.o mptsas.o
obj-$(CONFIG_FUSION_LAN)	+= mptlan.o
obj-m				+= mptctl.o
obj-m                           += mptcfg.o
obj-m                       +=mptstm.o


this will compile and modules can be installed
successfully.

I need to have a comfunc.c file, which contains all
common functions, which could be used by these module
files.
I added the line below to the content just below
mptstm.o (I tried adding just above mptlan). All
modules are compiled successfully. I can install
mptbase.ko. However, when I try to install mptctl.ko
(or other modules), I got errors like mptctl: Unknown
symbol mpt_register; mpt_deregister. These functions
are implemented in mptbase.c.

How do I fix this problem?

thanks
Robert
mptbase-objs             := comfunc.o

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
