Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312848AbSDFWEL>; Sat, 6 Apr 2002 17:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312850AbSDFWEK>; Sat, 6 Apr 2002 17:04:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32569 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312848AbSDFWEJ>; Sat, 6 Apr 2002 17:04:09 -0500
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Byron Stanoszek <gandalf@winds.org>, Jeremy Jackson <jerj@coplanar.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Faster reboots - calling _start?
In-Reply-To: <Pine.LNX.4.44.0204061201281.7190-100000@winds.org>
	<1745393533.1018100235@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Apr 2002 14:57:33 -0700
Message-ID: <m1hemoo5gy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <Martin.Bligh@us.ibm.com> writes:

> > Wouldn't it be easier to just ljmp to the start address of the kernel in
> > memory (the address after the bootloader has done its thing), effectively
> > restarting the kernel from line 1? Or is tehre an issue with some
> > hardware being in an invalid state when doing this?
> 
> Two issues with that:
> 
> 1. I want to be able to boot a different kernel on reboot - this
> is a development machine.
> 
> 2. I believe we free all the __init stuff around the end of
> start_kernel, so the initial functions and data just aren't 
> there any more ... of course that could be changed, but it's
> both a more major change than I really want to do, and it still
> doesn't solve (1) ;-)

Seriously check out my code it should just work unless there are special
apic shutdown rules for NUMAQ machines.

Eric

