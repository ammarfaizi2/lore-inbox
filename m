Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280744AbRKJWtS>; Sat, 10 Nov 2001 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKJWtI>; Sat, 10 Nov 2001 17:49:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:17676 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280744AbRKJWsv>;
	Sat, 10 Nov 2001 17:48:51 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: panxer@hol.gr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile problem 2.4.14 
In-Reply-To: Your message of "Sat, 10 Nov 2001 22:15:00 +0200."
             <01111022150000.00265@gryppas> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Nov 2001 09:48:40 +1100
Message-ID: <22928.1005432520@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001 22:15:00 +0200, 
Panagiotis Moustafellos <panxer@hol.gr> wrote:
>I am really getting a hard time compiling the 2.4.14..
>My current system has a 2.4.13 (by patching all the way
>from 2.4.9), so I patched the sources, yes after make clean,
>make menuconfig, and make dep ; make bzImage, I get this
>message (during the compilation of vmlinux )
>
>fs/fs.o: In function `dput':
>fs/fs.o(.text+0x10ad5): undefined reference to `atomic_dec_and_lock'
>make: *** [vmlinux] Error 1

You need to make mrproper.  There is a spurious #define for
atomic_dec_and_lock lurking in the old modversion tables.

