Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWGKSCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWGKSCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWGKSCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:02:16 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:1626 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751166AbWGKSCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:02:15 -0400
Message-ID: <44B3E7A2.1070102@tls.msk.ru>
Date: Tue, 11 Jul 2006 22:02:10 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3E3E0.1050100@tls.msk.ru> <20060711175249.GA16869@suse.de>
In-Reply-To: <20060711175249.GA16869@suse.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
>  On Tue, Jul 11, Michael Tokarev wrote:
> 
>> Olaf Hering wrote:
>> []
>>> To create the initrd you needed a loop file, at least for ext2, minix etc.
>> It's just damn trivial to pack your files into cpio archive and gzip it.
> 
> The point is not how trivial it is. The point is how much has to change
> that you can run 2.6.42 on an 42 year old installation with the tools
> that were available at that time.

I'd say you've ZERO chance to run just new kernel.  You will need more
recent glibc, never softraid tools, you will discover that /dev/hdXX are
all gone, and so on.

> Obiviously you cant be bothered to install newer packages, like kinit.rpm.
> Basic backwards compatibilty. Its not a term from the klingon dictionary.

Well.  I'd say it's not that obvious.  For example, I can't boot redhat-6.0
system with current 2.6 kernel (I once tried that, probably with 2.6.9 or
something - there were quite.. some problems.  Upgrading several packages,
including glibc compiled against 2.6 kernel, solved that. Some stuff was
still broken, but I didn't try hard).  BTW, devfs is just one example...
try to boot a one-year-old gentoo distro (not 42, but 1) with current
2.6 without devfs... ;)

Another point is: why the heck you want to boot such 42-years-old system
with current "best, grestest" kernel, anyway?

> Btw, kinit is already taken, some kerberos thing.

Heh. Yes it is.

/mjt
