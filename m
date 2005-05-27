Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVE0U7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVE0U7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVE0U7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:59:44 -0400
Received: from [81.2.110.250] ([81.2.110.250]:60603 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262594AbVE0U7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:59:41 -0400
Subject: Re: disowning a process
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42976D3A.5020200@davyandbeth.com>
References: <42975945.7040208@davyandbeth.com>
	 <1117217088.4957.24.camel@localhost.localdomain>
	 <42976D3A.5020200@davyandbeth.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117227438.5730.235.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 27 May 2005 21:57:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-05-27 at 19:55, Davy Durham wrote:
> Cool.. I looked at the daemon function and I might be able to use it..

Using daemon() is generally wise - it is basically a double fork and
then one exits so that the orphan child becomes owned by init. However
it also knows about platform specific considerations like setpgrp v
setsid, whether an ioctl must be done to disown the controlling tty etc
which can be fairly OS generation specific.

