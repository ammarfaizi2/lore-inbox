Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVDKKNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVDKKNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVDKKNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:13:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62941 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261756AbVDKKNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:13:50 -0400
Date: Mon, 11 Apr 2005 12:13:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: folkert@vanheusden.com
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 0/3] encrypted swsusp image
Message-ID: <20050411101324.GA1353@elf.ucw.cz>
References: <4259B46D.9020402@domdv.de> <20050411075441.GT29797@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411075441.GT29797@vanheusden.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The following patches allow for encryption of the on-disk swsusp image
> > to prevent data gathering of e.g. in-kernel keys or mlocked data after
> > resume.
> > For this purpose the aes cipher must be compiled into the kernel as
> > module load is not possible at resume time.
> > A random key is generated at suspend time, stored in the suspend header
> > on disk and deleted from the header at resume time. If you don't resume
> > a mkswap on the suspend partition will also delete the temporary key.
> > Only the data pages are encrypted as only these may contain sensitive data.
> > This works on my x86_64 laptop (64bit mode) and probably needs testing
> > on other platforms.
> 
> What about an option for an user-defined key? One that can be set when
> suspending?

That's logical next step, but lets try to solve one problem at a time.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
