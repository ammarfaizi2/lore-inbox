Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVA1CkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVA1CkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 21:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVA1CkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 21:40:03 -0500
Received: from [220.248.27.114] ([220.248.27.114]:22677 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261406AbVA1Cjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 21:39:49 -0500
Date: Fri, 28 Jan 2005 10:36:37 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Applications segfault on evo n620c with 2.6.10
Message-ID: <20050128023636.GA3919@hugang.soulinfo.com>
References: <20050127184334.GA1368@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127184334.GA1368@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 07:43:34PM +0100, Pavel Machek wrote:
> Hi!
> 
> It happened for 3rd in a week now...
> 
> When problem happens, processes start to segfault, usually right
> during startup. Programs that were loaded prior to problem usualy
> works, and can be restarted. I also seen sendmail exec failing with
> "no such file or directory" when it clearly was there. Reboot corrects
> things, and filesystem (ext3) is not damaged.
> 
> Unfortunately I do not know how to reproduce it. I tried
> parallel-building kernels for few hours and that worked okay. Swsusp
> is not involved (but usb, bluetooth, acpi and sound may be).
> 
> Does anyone else see something similar?

I got the same thing in my computer. 

Maybe this can reproduce it.
 1: add this in boot loader 
    "init=/bin/sh"
 2: after system boot, then active swap space, then do suspend.
 3: after system resume, the sh will crash like. 
    that can 100% reproduce it my in X86, X86_64, PPC32.

The Software suspend2 has not that problem. 
 
-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
