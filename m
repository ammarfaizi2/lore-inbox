Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVHHMLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVHHMLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 08:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVHHMLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 08:11:31 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:26556 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S1750837AbVHHMLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 08:11:30 -0400
Date: Mon, 08 Aug 2005 21:06:45 +0900 (JST)
Message-Id: <20050808.210645.78734846.kaminaga@sm.sony.co.jp>
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HELP] How to get address of module
From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
In-Reply-To: <20050808214822.531ee849.sfr@canb.auug.org.au>
References: <20050808.204022.30161255.kaminaga@sm.sony.co.jp>
	<20050808214822.531ee849.sfr@canb.auug.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm looking for *nice* way to get address of loaded module in 2.6.
> > I'd like to know the address from driver.
> 
> Maybe explaining why you need the address of a module would help.

I'm currently writing a driver to diagnose/monitor the error, such as 
core dump.

I inserted some hook in kernel, and when segfault occurs, control is 
transfered to my driver to analyze.

If the cause is in some insmod'ed module, then I would like to get
info of that module. If I get the address of that module, I can get
info such as symbol name defined by that module, etc. Then I could say
in module mmm, at func fff, at addr xxx, there is segfault.

Core dump could be in userspace app, so, in the driver I'm writting now,
I'm using same data structure to hold info of ELF file. If it was in app,
I'm getting address from current->mm->mmap->vm_start.


HK.
--
