Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132328AbRDCCdm>; Mon, 2 Apr 2001 22:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132226AbRDCCdW>; Mon, 2 Apr 2001 22:33:22 -0400
Received: from math.umd.edu ([129.2.56.22]:51350 "EHLO math.umd.edu") by vger.kernel.org with ESMTP id <S132224AbRDCCdN>; Mon, 2 Apr 2001 22:33:13 -0400
Date: Mon, 2 Apr 2001 22:32:30 -0400
From: Tim Strobell aka Griffy <griffy@math.umd.edu>
To: linux-kernel@vger.kernel.org
Subject: size of ring buffer for kernel msgs
Message-ID: <20010402223230.A1188@laplace.math.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel gurus,

Since the boot process on some SMP machines can be rather verbose, it seems
that the ring buffer for printk()s wraps before it can be snarfed by
klogd/syslogd after boot.
This makes it difficult to troubleshoot messages printed early in the boot
process (like BIOS RAM maps).

The default buffer size is 16k. (kernel/printk.c, line 26) 
Would it be reasonable to increase this to 32k (or more) on most machines? 

The buffer size is set at compile-time, and may present a problem in
limited-memory (embedded?) systems if grown too large.

Comments are most welcome.

Tim

--
Tim "Griffy" Strobell, griffy@math.umd.edu, (301) 405-8175
Assistant Sysadmin and Server Janitor
Department of Mathematics, University of Maryland at College Park
