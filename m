Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSJZNvN>; Sat, 26 Oct 2002 09:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbSJZNvN>; Sat, 26 Oct 2002 09:51:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51507 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262130AbSJZNvL>; Sat, 26 Oct 2002 09:51:11 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: kexec for 2.5.44 (Who do I send this to?)
References: <m1y98uyc1a.fsf@frodo.biederman.org>
	<20021020190939.GA913@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Oct 2002 07:54:41 -0600
In-Reply-To: <20021020190939.GA913@elf.ucw.cz>
Message-ID: <m1lm4ll2zi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > The kexec code has gone through a fairly decent review, and all known bugs
> > are resolved.  There are still BIOS's that don't work after you have
> > run a kernel but that is an entirely different problem.  
> 
> Looks good... Few comments follow.

> Perhaps this should be done using driverfs callbacks?


SMP must be stopped and the APIC shutdown as the very last thing to happen.
The order dependency is a very real, and ugly things happen when it
doesn't happen as the very last thing.  Does driverfs have a way to
express that? 

Eric

