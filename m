Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268276AbTGLSjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbTGLSjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:39:15 -0400
Received: from 200-63-154-130.speedy.com.ar ([200.63.154.130]:3202 "EHLO
	runa.sytes.net") by vger.kernel.org with ESMTP id S268276AbTGLSjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:39:14 -0400
Date: Sat, 12 Jul 2003 15:54:00 -0300
From: Martin Sarsale <lists@runa.sytes.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.75 everything looks ok!
Message-Id: <20030712155400.4247908f.lists@runa.sytes.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im not sure if you appreciate this kind of messages, but I've just booted linux 2.5.75 and after installing module-init-tools everything works as expected :)

PIII 450
Realtek 8139 (using 8139too)
3 Reiser fs partitions (including root)
ADSL

I found only one rare thing: when I run "make modules_install" a lot of modules had missing symbols.  Im not sure but it think it has something to do with the crc32 module: when I got the messages about the missing symbols, I hadn't compiled crc32, after that I compiled and loaded it, "make modules_install" worked like a charm

Another thing: 
Using module-init-tools 0.9.13-pre when I try to load any module using modprobe I get a "FATAL: Module module not found":

modprobe crc32
FATAL: Module crc32 not found.

Instead, I have to use insmod and the full module path (insmod /lib/modules/2.5.75/kernel/lib/crc32.ko  works ok).


