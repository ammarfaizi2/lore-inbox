Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUDPRJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 13:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDPRJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 13:09:22 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:22465 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263484AbUDPRJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 13:09:17 -0400
Date: Fri, 16 Apr 2004 10:09:15 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: How to make stack executable on demand?
Message-ID: <20040416170915.GA20260@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the non-executable stack kernel, how can I make stack executable
on demand? If I set kernel with non-executable stack, only those
binaries marked with executable PT_GNU_STACK will have executable
stack. But a binary with non-executable PT_GNU_STACK may dlopen a
DSO with executable PT_GNU_STACK. The dynamic linker will try to
make stack executable with mprotect. But it will either fail if
kernel is set with non-executable stack, or be a no-op if kernel
is set with executable stack. Is there a third option that a process
starts with non-executable stack and can change the stack permission
later?



H.J.
