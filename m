Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUJPTo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUJPTo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUJPTmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:42:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25362 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268799AbUJPTkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:40:11 -0400
Date: Sat, 16 Oct 2004 20:40:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dan Kegel <dank@kegel.com>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well (was: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?)
Message-ID: <20041016204001.B20488@flint.arm.linux.org.uk>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk> <20041016212440.GA8765@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041016212440.GA8765@mars.ravnborg.org>; from sam@ravnborg.org on Sat, Oct 16, 2004 at 11:24:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 11:24:40PM +0200, Sam Ravnborg wrote:
> On Sat, Oct 16, 2004 at 08:06:27PM +0100, Russell King wrote:
> > 
> > Converting .S -> .s is useful for debugging - please don't cripple the
> > kernel developers just because some filesystems are case-challenged.
> 
> Does the debug tools rely on files named *.s then?
> 
> There are today ~1400 files named *.S in the tree, but none named *.s.
> So my idea was to do it like:
> *.S => *.asm => *.o
> But if this breaks some debugging tools I would like to know.

*.asm is nonstanard naming.  If we have to support case-challenged
filesystems, please ensure that the rest of the nonbroken world can
continue as they have done for the last few decades and live happily
unaffected by these problems.

> Btw. this is not about "case-challenged" filesystems in general. This is
> about making the kernel usefull out-of-the-box for the increasing
> embedded market.
> Less work-around patces needed the better. And these people are often
> bound to Windoze boxes - for different reasons. And the individual
> developer may not be able to change this.

You still need a case-sensitive filesystem to be able to create a root
filesystem for their embedded device.  I think you'll find that issues
surrounding caseful filenames in the kernel is the least of their
problems.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
