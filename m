Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbUDBIiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbUDBIiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 03:38:24 -0500
Received: from gprs213-119.eurotel.cz ([160.218.213.119]:3969 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263336AbUDBIiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 03:38:23 -0500
Date: Fri, 2 Apr 2004 10:38:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] don't support %n in printk
Message-ID: <20040402083812.GA375@elf.ucw.cz>
References: <20040320231438.GX13042@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320231438.GX13042@mulix.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The printf man page has this to say about '%n': 
> 
> "The number of characters written so far is stored into the integer
> indicated by the int * (or variant)  pointer argument.   No argument
> is converted." 
> 
> Very little code actually uses %n for that. Now days, %n has a much
> more common use - in printf format string exploits. Since no kernel
> code appears to be using %n (thus said grep), this patch removes
> support for it. To preempt the obvious argument, I agree that printk
> should look and behave as much as possible as printf - except where
> it's harmful. We don't support floating point, for example, and I
> doubt we should support %n - although I don't strongly care one way or
> another. 

You probably should search the kernel for any uses of %n and fix
them...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
