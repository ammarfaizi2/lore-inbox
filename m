Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265719AbUFOQA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUFOQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbUFOQA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:00:27 -0400
Received: from ned.cc.purdue.edu ([128.210.189.24]:42625 "EHLO
	ned.cc.purdue.edu") by vger.kernel.org with ESMTP id S265719AbUFOQA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:00:26 -0400
From: Patrick Finnegan <pat@computer-refuge.org>
To: linux-kernel@vger.kernel.org
Subject: Compile problems on alpha: 2.6.6, 2.6.7-rc2
Date: Tue, 15 Jun 2004 11:00:25 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406151100.25284.pat@computer-refuge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not quite sure what's causing this, but I get the following error
message (make V=1):

        ld  -static -N  -T arch/alpha/kernel/vmlinux.lds.s 
arch/alpha/kernel/head.o   init/built-in.o --start-group  usr/built-in.o  
arch/alpha/kernel/built-in.o  arch/alpha/mm/built-in.o  
arch/alpha/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o  
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  
lib/lib.a  arch/alpha/lib/lib.a  lib/built-in.o  
arch/alpha/lib/built-in.o  drivers/built-in.o  sound/built-in.o  
net/built-in.o --end-group  -o .tmp_vmlinux1
local symbol 0: discarded in section `.exit.text' from drivers/built-in.o

make then aborts at this step.  At other times, I've gotten errors that
read the same as the above line, for symbols "1" through "4", in order.

I'm going to guess there's a problem with one of the drivers I've got 
built-in to the kernel, but I haven't been able to figure much else out..
I tried using readelf, but didn't find the "0" symbol.

.config and drivers/built-in.o are at http://x-ray.rcs.purdue.edu/alpha-2.6/

gcc version is "gcc (GCC) 3.3.3 (Debian 20040422)"
binutils version is "2.14.90.0.7 20031029 Debian GNU/Linux"

Pat
-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
