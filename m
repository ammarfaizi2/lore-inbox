Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270583AbTGUQuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270592AbTGUQuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:50:10 -0400
Received: from smtp.terra.es ([213.4.129.129]:49467 "EHLO tfsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S270583AbTGUQtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:49:31 -0400
From: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
To: linux-kernel@vger.kernel.org
Message-ID: <5df3060bad.60bad5df30@teleline.es>
Date: Mon, 21 Jul 2003 19:04:29 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Re: Suggestion for a new system call: convert file handle to a
 cookie for transfering file handles between processes.)
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many of you have said that it is not a good thing to bloat the kernel
with new system calls. But for that purpose, it is important to design
the system interface in such way that primitives can be combined
together to get any desired result.

This is the reason why Linux clone() is better than Solaris threads, why
Unix fork()+execve() is better than Windows CreateProcess(). The former
are more simple primitives. They encourage simple and thus less error
prone code both in the kernel as in user space applications.

And that is exactly the reason why I like the interface that I designed.
As opposed to transfer of handles through unix domain sockets, that is
tied to unix sockets, my interface is more primitive. It is not tied to
anything. You get a representation of a file handle, and then you can
transfer it through a regular file, a pipe, ...

Ramon


