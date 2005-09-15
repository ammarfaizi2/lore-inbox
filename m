Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVIOJNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVIOJNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVIOJNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:13:49 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:57795 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S932278AbVIOJNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:13:49 -0400
Message-ID: <43293AE4.5050308@cs.aau.dk>
Date: Thu, 15 Sep 2005 11:12:04 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Automatic Configuration of a Kernel
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <6bffcb0e05091415533d563c5a@mail.gmail.com> <4328B710.5080503@in.tum.de>
In-Reply-To: <4328B710.5080503@in.tum.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Thaler wrote:
> 
> I like the idea.
> I'm a power user and of course I can do make menuconfig, but it would be
> useful when building a kernel for new hardware for example.

I agree ! When compiling for a new platform you would like to have at
least a minimal skeleton of the .config which is working for your
machine and then add stuff like NFS, netfilter, and other stuff.

Something like:

make autoconfig ---> generate a skeleton (compile and run)
make menuconfig ---> add the stuff you want (file systems, firewall, ...)

However, if the "make autoconfig" target generate nothing but a bare
minimal .config which is fitting exactly your hardware, which would
compile and run on your platform (with a stripped down network layer,
only one file system, etc). Then I would like to have this.

> Currently that involves looking at dmesg output to figure out the correct
> options; this would provide a nice base config to work with and reduce the
> amount of effort.

Yes. Especially for strange platforms where you usually end-up with a
try and error methodology... (yes, I got a Transmeta Crusoe Sony Vaio
C1-MZX once ! :)).

Regards
-- 
Emmanuel Fleury

Assistant Professor          | Office: B1-201
Computer Science Department, | Phone:  +45 96 35 72 23
Aalborg University,          | Mobile: +45 26 22 98 03
Fredriks Bajersvej 7E,       | E-mail: fleury@cs.aau.dk
9220 Aalborg East, Denmark   | URL: www.cs.aau.dk/~fleury

