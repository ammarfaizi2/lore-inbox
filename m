Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbUDRANJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUDRANJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:13:09 -0400
Received: from sankara1.bol.com.br ([200.221.24.109]:8182 "EHLO
	sankara1.bol.com.br") by vger.kernel.org with ESMTP id S264092AbUDRANF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:13:05 -0400
Subject: local interrupt disabling
From: Fabiano Ramos <fabramos@bol.com.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082247507.1201.7.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 17 Apr 2004 21:18:27 -0300
Content-Transfer-Encoding: 7bit
X-Sender-IP: 200.165.174.198
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

	I am doing some work on 2.4 to count the number of instructions
executed for a given syscall.I set the trap bit on eflags at the syscall
entry, causing a trap for each instruction executed until the iret at
return_from_syscall. At the debug handler, I increment my counter.
	I know that the syscall code cannot be preempted by another
exeception handler, only by interrupts or page faults it causes.
I want to track the page faults, no problem, but I wouldn't like
the syscall to be interrupted by a mouse interrupt, for examnple.
Local interrupt disabling while servicing the syscall would solve
my problem, or would it create other problems?

TIA,
Fabiano


