Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262652AbREOGih>; Tue, 15 May 2001 02:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbREOGi1>; Tue, 15 May 2001 02:38:27 -0400
Received: from bsd.ite.com.tw ([210.208.198.222]:38416 "EHLO bsd.ite.com.tw")
	by vger.kernel.org with ESMTP id <S262652AbREOGiM>;
	Tue, 15 May 2001 02:38:12 -0400
From: Rich.Liu@ite.com.tw
Message-ID: <412C066DD818D3118D4300805FD4667902090B77@ITEMAIL>
To: linux-kernel@vger.kernel.org
Subject: Memory Access Problem
Date: Tue, 15 May 2001 14:36:51 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="Big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem in kernel 2.4.4

I use readw to access memory below 1MB , report "Segmentation fault"
and stall in memory

simple code below (this will get paraller port)
==
int init_module(void){
	unsigned int   *BIOS_Data=(unsigned int *)0x400;
	u32 test;
                test = readw(BIOS_Data);

	 printk(KERN_CRIT  "0x400:%x\n",test);
}
==
but those can work in kernel 2.2.19 , no problem .

can anyone help me ?
--
Richliu                                                       

