Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVA0KLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVA0KLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVA0KLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:11:20 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:40196 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262543AbVA0KLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:11:19 -0500
Date: Thu, 27 Jan 2005 10:11:17 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Patch 0/6  virtual address space randomisation
Message-ID: <20050127101117.GA9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The randomisation patch series introduces infrastructure and functionality
that causes certain parts of a process' virtual address space to be
different for each invocation of the process. The purpose of this is to
raise the bar on buffer overflow exploits; full randomisation makes it not
possible to use absolute addresses in the exploit.

This first series only does a partial randomisation, future series will
randomize other parts of the virtual address space as well.

01-sysctl-A0			- introduce a sysctl to enable/disable
02-randomize-infrastructure	- infrastructure helpers
03-PF_RANDOMIZE			- per process flag to enable/disable
04-stack			- start randomizing the stack pointer
05-mmap				- start randomizing mmap addresses
06-default-enable		- enable randomisation by default (for -mm testing only) 

This series does NOT randomize the brk() area and does not yet add support
for PIE binaries. This I will leave to a next series; this one should first
settle down.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
