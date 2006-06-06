Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWFFKmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWFFKmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWFFKmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:42:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:6279 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750980AbWFFKmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:42:32 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64: 64 bit kernel 32 bit userland - some pending questions
References: <20060606093456.GL4552@cip.informatik.uni-erlangen.de>
From: Andi Kleen <ak@suse.de>
Date: 06 Jun 2006 12:42:30 +0200
In-Reply-To: <20060606093456.GL4552@cip.informatik.uni-erlangen.de>
Message-ID: <p73lksazht5.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

> Hello everyone,
> I would like to use an AMD64 Opteron System with a 64 bit Linux Kernel,
> but a 32 bit userland (Debian Sarge). I have a few questions about this:

The main caveat is that iptables and ipsec need 64bit executables
to be set up. The rest should work.

> 
>         - Is it possible to give the userland 3Gbyte virtual address
>           space (default for 2.4 and 2.6).

The default is 4GB, but you can get 3GB by running it under linux32 --3gb

> But give the Kernel a 64 bit
>           virtual address space so that I get more than 1 Gbyte physical
>           Memory into LOWMEM - say I want 8 Gbyte - without using HIGHMEM

The 64bit kernel never uses highmem.

>         - What is the easiest way to build a 64 bit kernel on a 32 bit
>           Debian sarge. Are there crosscompiler packages available? Are
>           there any guides on this?

If all fails you can get a cross compiler from crosstool.
Then normal kernel compilation command with 

make ... ARCH=x86_64 CROSS_COMPILE=x86_64-linux-
 

-Andi
