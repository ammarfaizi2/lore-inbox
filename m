Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVCEF0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVCEF0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 00:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVCEFQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 00:16:46 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:37255 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S263538AbVCEFKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 00:10:43 -0500
Date: Sat, 5 Mar 2005 00:09:29 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Adrian Bunk <bunk@stusta.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>,
       <keenanpepper@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
In-Reply-To: <20050304202842.GH3327@stusta.de>
Message-ID: <Pine.LNX.4.44.0503050004120.20007-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Adrian Bunk wrote:

> > [...] So ld looks into the lib .a archive, determines that none of 
> > the symbols in that object file are needed to resolve a reference and 
> > drops the entire .o file.

> Silly question:
> What's the advantage of lib-y compared to obj-y?

Basically exactly what I quoted above -- unused object files don't get
linked into the kernel image and don't take up (wasted) space. On the
other hand, files in obj-y get linked into the kernel unconditionally.

--Kai


