Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVFLPLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVFLPLe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVFLPLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:11:34 -0400
Received: from rly-ip04.mx.aol.com ([64.12.138.8]:31961 "EHLO
	rly-ip04.mx.aol.com") by vger.kernel.org with ESMTP id S262614AbVFLPLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:11:32 -0400
Date: Sun, 12 Jun 2005 17:10:50 +0200
From: DJ.CnX@phreaker.net
To: linux-kernel@vger.kernel.org
Subject: ld bug
Message-Id: <20050612171050.529d5be8.DJ.CnX@phreaker.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AOL-IP: 195.93.61.82
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello guys....

source:

section .text

global main

msg db "och bin",0x0
msg_len equ $-msg

main:
           pusha
           mov eax,4
           mov ebx,1
           mov ecx,msg
           mov edx,msg_len
           int 0x80

           popa
           xor eax,eax
           inc eax
           int 0x80


compilation command:
sh# nasm -f elf -o new.o new.asm
sh# ld -e main -o new new.o
sh# strace ./new
execve("./new", ["./new"], [/* 78 vars */]) = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++


i compiled the whole shit with gcc and it worked... .-/
