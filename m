Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVDITyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVDITyd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 15:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDITyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 15:54:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:52670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261377AbVDITyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 15:54:31 -0400
Date: Sat, 9 Apr 2005 12:56:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0504091253070.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, Linus Torvalds wrote:
> 
> To actually change the working directory, you'd first get the index file
> setup, and then you do a "checkout-cache -a" to update the files in your
> working directory with the files from the sha1 database.

Btw, this will not overwrite any old files, so if you have an old version 
of something, you'd need to do "checkout-cache -f -a" (and order matters: 
the "-f" must come first). This time I actually have a big comment at the 
top of the checkout-cache.c file trying to explain the logic.

			Linus
