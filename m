Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVIVTsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVIVTsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVIVTsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:48:10 -0400
Received: from webmail2-gw.fasthost.com.br ([200.183.77.27]:21405 "HELO
	webmail2.locasite.com.br") by vger.kernel.org with SMTP
	id S1030231AbVIVTsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:48:09 -0400
Date: 22 Sep 2005 19:44:33 -0000
Message-ID: <20050922194433.13200.qmail@webmail2.locasite.com.br>
From: breno@kalangolinux.org
To: linux-kernel@vger.kernel.org
Subject: security patch 
X-Mailer: Locasite Webmail
X-IPAddress: 200.101.52.3
X-Priority: 3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I'm doing a new feature for linux kernel 2.6 to protect against all kinds of buffer
overflow. It works with new sys_control() system call controling if a process can or can't
call a system call ie. sys_execve();

You can do it using /bin/sys_control <pid> <enable or not system call> <eax of system
call> <secret number>
for process that never call for example sys_execve(), setuid() ( you must need specify
each eax for each system call) and use some functions in sys_control.h like lock_execve(n)
and unlock_execve(n), where n is a secret number defined in sysctl. With this functions
you will use system calls only when you need. 
All shellcodes that use system calls like sys_execve() sys_setuid() will not work with
this feature.

I think it can be an option in linux kernel.

Questions .. suggestions.

Thanks

Breno at kalangolinux.org 

