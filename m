Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWAFBfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWAFBfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWAFBfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:35:31 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:18877 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751709AbWAFBfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:35:31 -0500
Date: Thu, 5 Jan 2006 20:35:24 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060106013524.GF5516@filer.fsl.cs.sunysb.edu>
References: <20060106001943.GE5516@filer.fsl.cs.sunysb.edu> <E1EugA7-00075r-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EugA7-00075r-00@calista.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 02:12:59AM +0100, Bernd Eckenfels wrote:
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> > That's something to watch out for...If you say have:
> > 
> > printk(KERN_DEBUG "fooo.....");
> > do_foo();
> > printk(KERN_DEBUG "done.\n");
> 
> dont do it. It is better to have the time stamps for both and to have atomic
> prints.

First of all, the above code is to just illustrate a point. And as a matter of
fact it may not even work if some other kernel thread prints something while
do_foo() is executing, the whole thing will get screwed up.

If I remember correctly, I the second line of the "sample" code, will _NOT_
produce a timestamp. So, the output will be:

[1234567.123456] fooo.....<7>done.

where, the timestamp is that of the first printk.

> In fact I would disallow this and add automatic linebreaks.

I wouldn't go that far. I'd just let the kernel janitors people have fun with
the existing code :)

Jeff.
