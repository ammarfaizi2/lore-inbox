Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWCKXii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWCKXii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 18:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWCKXii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 18:38:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbWCKXii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 18:38:38 -0500
Date: Sat, 11 Mar 2006 15:36:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, ak@suse.de
Subject: Re: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on AMD64
Message-Id: <20060311153618.2e4b113d.akpm@osdl.org>
In-Reply-To: <200603120024.04938.rjw@sisk.pl>
References: <200603120024.04938.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Hi,
> 
> With the 2.6.16-rc5-mm3 kernel w/ the patch
> 
> revert-x86_64-mm-i386-early-alignment.patch
> 
> applied I'm able to hang my box (Asus L5D, 1 CPU, x86-64 kernel) solid
> by running OpenOffice.org from under KDE (100% of the time but on one
> user account only).  Before it hangs I get something like this on the serial console:
> 
> BUG: spinlock bad magic on CPU#0, soffice.bin/5293
>  lock: ffff81005e174e28, .magic: 000001ff, .owner: .5).@4).06)./0, .owner_cpu: -2141827648
> BUG: spinlock lockup on CPU#0, soffice.bin/5293, ffff81005e174e28
> 

Is it a !CONFIG_SMP kernel?

There's no stack trace?
