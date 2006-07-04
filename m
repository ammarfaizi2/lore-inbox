Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWGDAZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWGDAZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGDAZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:25:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751329AbWGDAZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:25:02 -0400
Date: Mon, 3 Jul 2006 17:24:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: swsusp regression
Message-Id: <20060703172455.d45edb0a.akpm@osdl.org>
In-Reply-To: <44A9AD48.5020400@gmail.com>
References: <44A99DFB.50106@gmail.com>
	<44A99FE5.6020806@gmail.com>
	<20060703161034.a5c4fba9.akpm@osdl.org>
	<44A9AD48.5020400@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2006 01:50:09 +0159
Jiri Slaby <jirislaby@gmail.com> wrote:

> Andrew Morton napsal(a):
> > On Tue, 04 Jul 2006 00:53:02 +0159
> > Jiri Slaby <jirislaby@gmail.com> wrote:
> > 
> >> Jiri Slaby napsal(a):
> >>> Hello,
> >>>
> >>> when suspending machine with hyperthreading, only Freezing cpus appears and then
> >> Note: suspending to disk; done by:
> >> echo reboot > /sys/power/disk
> >> echo disk > /sys/power/state
> >>
> >>> it loops somewhere. I tried to catch some more info by pressing sysrq-p. Here
> >>> are some captures:
> >>> http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
> >>> http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif
> >> One more from some previous kernels (cutted sysrq-t):
> >> http://www.fi.muni.cz/~xslaby/sklad/22062006046.jpg
> >>
> > 
> > If you replace kernel/stop_machine.c with the version from 2.6.17, does it
> > help?
> 
> Yup. It seems so.
> 

OK.  I don't see what the problem is - let's just revert it.
