Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTFFVZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTFFVZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:25:33 -0400
Received: from ns.suse.de ([213.95.15.193]:17680 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262285AbTFFVZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:25:31 -0400
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: warren@togami.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 thru bk10 amd64 compile failure
References: <1054878617.3699.134.camel@laptop.suse.lists.linux.kernel>
	<1054917352.28218.3.camel@serpentine.internal.keyresearch.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Jun 2003 23:39:03 +0200
In-Reply-To: <1054917352.28218.3.camel@serpentine.internal.keyresearch.com.suse.lists.linux.kernel>
Message-ID: <p73smqm6g3s.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan <bos@serpentine.com> writes:

> On Thu, 2003-06-05 at 22:50, Warren Togami wrote:
> 
> > kernel-2.5.70, 2.5.70-bk9 and 2.5.70-bk10 all fail compilation here on
> > my amd64 with gcc-3.2.2-10 on stock RedHat GinGin64.  Please pardon me
> > if this is a duplicate report, I am now subscribing in order to keep a
> > closer eye on this list.
> 
> You're compiling with CONFIG_VT turned off.  Turn it on for now, as I
> don't have a patch for that problem yet.

See it as a feature. Compiling with CONFIG_VT off is in 99.999999999%
of all cases a mistake. On AMD64 it is more likely 100% ;-)
  
Seriously is quite possible that obscure configurations do not compile on amd64
(obscure is anything that is not like arch/x86_64/defconfig ;) 
They are not regularly tested. Patches are welcome.

As for CONFIG_VT I think this option should really be wrapped by 
CONFIG_EMBEDDED, Turning it off is near always a mistake.
Same for the keyboard drivers in the input layer at least for CONFIG_X86.
This would work with make oldconfig too from 2.4 config files
unlike the current way.

-Andi
