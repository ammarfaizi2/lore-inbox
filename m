Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVCEPVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVCEPVL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVCEPVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:21:10 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:14984 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S261481AbVCEPUk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:20:40 -0500
Date: Sat, 5 Mar 2005 10:19:23 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Adrian Bunk <bunk@stusta.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>,
       <keenanpepper@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
In-Reply-To: <20050305130416.GA6373@stusta.de>
Message-ID: <Pine.LNX.4.44.0503051012530.20560-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2005, Adrian Bunk wrote:

> And this can break as soon as the "unused" object files contains 
> EXPORT_SYMBOL's.
> 
> Is it really worth it doing it in this non-intuitive way?

I don't think it non-intuitive, it's how libraries work. However, as you 
say, it is broken for files containing EXPORT_SYMBOL.

The obvious fix for this case is the one that akpm mentioned way earlier 
in this thread, move parser.o into $(obj-y).

It should be rather easy to have the kernel build system warn you when you 
compile library objects exporting symbols.

--Kai


