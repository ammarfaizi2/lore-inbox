Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTKLQ1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTKLQ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:27:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:15266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262622AbTKLQ1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:27:53 -0500
Date: Wed, 12 Nov 2003 08:27:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Maciej Zenczykowski <maze@cela.pl>
cc: Solar Designer <solar@openwall.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <Pine.LNX.4.44.0311121421450.31972-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.44.0311120824450.3288-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Nov 2003, Maciej Zenczykowski wrote:
> 
> Well I got a hold of the necessary cabling and I'm sorry to report that
> there is absolutely nothing on the serial console - I get the boot
> messages, etc. fine, the last message before crashing is 'Loglevel set to
> 9' [invoked by hand via Alt+SysRq+9], after which I crash it with 'strace
> ls -lR /' (as a normal user) and nothing else shows up, no oops no nada.  

Ok. The nice thing about getting a serial console is that now you could 
try the NMI watchdog - just boot up with "nmi_watchdog=1" on the kernel 
command line (or "=2" - see Documentation/nmi_watchdog.txt for more 
information on it). 

That won't necessarily see the problem either, especially if it's a total 
hardware lockup brought on by X poking registers in unfortunate ways, but 
if it's a pure kernel lockup with interrupts disabled, it can help.

		Linus

