Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422890AbWI3B7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbWI3B7u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 21:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422896AbWI3B7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 21:59:50 -0400
Received: from web52806.mail.yahoo.com ([206.190.48.249]:4964 "HELO
	web52806.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1422895AbWI3B7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 21:59:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VmFb7eJNywNC772mjODCNFUm+B6H998fGcLbovML5WwiKaz/Ba9RkAlBmd9YXFbC7lqi8r22EThbpJ1Qta5hqbBX15oFJcfrfh92NtITS7Idbg9wObcdoBR/LpUKmQMI0G2F5k+SqE9j5qXuqr2FfaHjmazgSdbNH145veSZaq4=  ;
Message-ID: <20060930015948.31753.qmail@web52806.mail.yahoo.com>
Date: Fri, 29 Sep 2006 18:59:48 -0700 (PDT)
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
   I have a makefile to make several driver modules:
obj-$(CONFIG_FUSION_SPI)	+= mptbase.o mptscsih.o
mptspi.o
obj-$(CONFIG_FUSION_FC)		+= mptbase.o mptscsih.o
mptfc.o
obj-m				+= mptbase.o mptscsih.o mptsas.o
obj-$(CONFIG_FUSION_LAN)	+= mptlan.o
obj-m				+= mptctl.o
obj-m                           += mptcfg.o
obj-m                       +=mptstm.o


this will compile all modules and the modules can be
installed successfully.

I need to have a comfunc.c file, which contains all
common functions, which could be used by these module
files.
I added the line below to the content just below
mptstm.o (I tried adding just above mptlan). 
mptbase-objs             := comfunc.o

All modules are compiled successfully. I can install
mptbase.ko. However, when I try to install mptctl.ko
(or other modules), I got errors like mptctl: Unknown
symbol mpt_register; mpt_deregister. These functions
are implemented in mptbase.c.

How do I fix this problem?

thanks
Robert


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
