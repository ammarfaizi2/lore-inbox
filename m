Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTDLNnI (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 09:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTDLNnH (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 09:43:07 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:39174 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S263098AbTDLNnH (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 09:43:07 -0400
Date: Sat, 12 Apr 2003 15:54:57 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: sysenter on x86
Message-ID: <20030412135457.GB19869@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just added sysenter support for linux-2.5 on x86 to the diet libc, but
I noted that the original patch said user space should jump to
0xfffff000, which segfaults.  Jumping to 0xffffe000 works.

I suggest adding a comment somewhere in the kernel about the proper
calling convention, because the glibc code is frankly not readable in
this regard.

Also, I suggest adding this interface to kernel 2.4 to easy binary
compatibility.

Felix
