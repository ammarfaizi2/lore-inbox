Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbTL3SUH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 13:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbTL3SUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 13:20:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:51333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264347AbTL3SUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 13:20:04 -0500
Date: Tue, 30 Dec 2003 10:20:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0312301017290.2065@home.osdl.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
 <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
 <Pine.LNX.4.58.0312291502210.1586@home.osdl.org>
 <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Thomas Molina wrote:
> 
> attachment two is the result of:
> opreport -l vmlinux > vmlinux.txt

Are you sure you used the right vmlinux binary? Some of this looks 
pretty strange (module_text_address? Whaa?).

However, it also seems to point out that you have SLAB debugging with 
poisoning enabled. That will absolutely _kill_ your performance, and could 
easily explain part of the degradation.

		Linus
