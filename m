Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTKLK56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 05:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTKLK56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 05:57:58 -0500
Received: from gaia.cela.pl ([213.134.162.11]:21769 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261882AbTKLK55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 05:57:57 -0500
Date: Wed, 12 Nov 2003 11:57:54 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: x86 ptrace support question
Message-ID: <Pine.LNX.4.44.0311121150220.25832-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm ptraceing a child process and I'd like to take a peek at memory
pointed to by a seg:offs far pointer.  Assuming seg is normal userspace DS
then the ptrace(PEEKDATA,..) works fine.  If not then I must most likely
perform conversion to linear address by hand.  However for this I need to
get at the code16/32, address16/32, base, limit, etc info of the segment
descriptor for this (given) segment.  Obviously this data can be read from
the GDT/LDT.  Unfortunately I can't figure out how to get at this without
having to patch the traced program code with support routines for exactly
this purpose and then undoing this and continuing.

Thanks,
MaZe.


