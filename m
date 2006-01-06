Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751901AbWAFCVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWAFCVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbWAFCVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:21:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:27569 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751901AbWAFCVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:21:34 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060106013524.GF5516@filer.fsl.cs.sunysb.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EuhES-0007bO-00@calista.inka.de>
Date: Fri, 06 Jan 2006 03:21:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> First of all, the above code is to just illustrate a point. And as a matter of
> fact it may not even work if some other kernel thread prints something while
> do_foo() is executing, the whole thing will get screwed up.

Thats another reason to not do it. And this means for me, we do not need to
support or optimize for this kind of printk abuse.

> If I remember correctly, I the second line of the "sample" code, will _NOT_
> produce a timestamp. So, the output will be:
> 
> [1234567.123456] fooo.....<7>done.

> where, the timestamp is that of the first printk.

Yes, thats the other problem, you miss the timestamp for the end of a long
running operation. Thats why it is better to have that in two lines (maybe
the second line with smaller severity)

Gruss
Bernd
