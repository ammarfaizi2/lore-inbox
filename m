Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTJSSJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 14:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTJSSJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 14:09:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:18400 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262009AbTJSSJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 14:09:06 -0400
Date: Sun, 19 Oct 2003 11:07:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Emmanuel Fleury <fleury@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Porting code from 2.4.x to 2.6.x
Message-Id: <20031019110723.1cc38fc7.rddunlap@osdl.org>
In-Reply-To: <1066585811.2738.17.camel@rade7.s.cs.auc.dk>
References: <1066585811.2738.17.camel@rade7.s.cs.auc.dk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Oct 2003 19:50:11 +0200 Emmanuel Fleury <fleury@cs.auc.dk> wrote:

| Hi all,
| 
| I'm trying to port some code from 2.4.x to 2.6.x.
| I got a very strange error, that I would like to submit here (it might
| help, we never know).
| 
| I am working with a clean 2.6.0-test7 (the test8 is scaring me a little
| bit with all these reports I saw on the list :).
| 
|  irq.h
| =======
| 
| /lib/modules/2.6.0-stable/build/include/asm/irq.h:16:25: irq_vectors.h:
| No such file or directory
| 
| So basically, the "irq_vectors.h" file has disappeared...
| 
| But, we still can find it in:
| ./include/asm-um/irq_vectors.h
| ./include/asm-i386/mach-default/irq_vectors.h
| ./include/asm-i386/mach-visws/irq_vectors.h
| ./include/asm-i386/mach-pc9800/irq_vectors.h
| ./include/asm-i386/mach-voyager/irq_vectors.h
| 
| 
| Any ideas ????

You are building a module outside of the kernel tree?

Use a Makefile in the form that is documented in
linux/Documentation/kbuild/{modules,makefiles}.txt
and it will find that file and work.

--
~Randy
