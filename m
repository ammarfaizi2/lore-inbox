Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTFPSLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTFPSLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:11:33 -0400
Received: from palrel12.hp.com ([156.153.255.237]:4993 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264082AbTFPSL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:11:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16110.2948.423609.97108@napali.hpl.hp.com>
Date: Mon, 16 Jun 2003 11:25:08 -0700
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: force_successful_syscall_return() buggy?
In-Reply-To: <20030616185549.E13312@flint.arm.linux.org.uk>
References: <20030615193604.L5417@flint.arm.linux.org.uk>
	<16110.147.422432.486761@napali.hpl.hp.com>
	<20030616185549.E13312@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 16 Jun 2003 18:55:49 +0100, Russell King <rmk@arm.linux.org.uk> said:

  Russell> I through out the idea of accessing user registers for user space
  Russell> programs at the top of the kernel stack because it does not work for
  Russell> processes exec'd from kernel space.

It doesn't work for the execve() itself, but it works for all
subsequent syscalls.  force_successful_syscall() not working for
execve() is of course not a problem, since it returns only on error.

	--david
