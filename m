Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131058AbRAPLyI>; Tue, 16 Jan 2001 06:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbRAPLx6>; Tue, 16 Jan 2001 06:53:58 -0500
Received: from [195.127.46.11] ([195.127.46.11]:29963 "EHLO hsproxy01")
	by vger.kernel.org with ESMTP id <S131058AbRAPLxs>;
	Tue, 16 Jan 2001 06:53:48 -0500
Message-ID: <C113A60DF3FFD3118B9A00508BA8F54205DC88@hskomm02.heiler.com>
From: "Herrmann, Achim" <AHerrmann@heiler.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: modules, insmod and multiple object files
Date: Tue, 16 Jan 2001 12:56:33 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-OriginalArrivalTime: 16 Jan 2001 11:59:11.0553 (UTC) FILETIME=[BD247310:01C07FB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm new to device driver development under linux and I've a basic question
concerning modules, insmod and multiple object files.

Assume I have two object files "main.o" and "hwaccess.o". 
main.o contains the functions init_module(), cleanup_module() and some other
functions.
hwaccess.o contains some routines to access the hardware. The functions in
main.o depend on the routines existing in hwaccess.o.

main.o was created using language "C": gcc -c main.c -o main.o
and 
hwaccess.o was created using assembler: nasm -f elf hwaccess.asm -o
hwaccess.o

Is there a possibility to combine these two object files, so that I have a
module which is loadable by insmod?


Thanks in advance
Achim



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
