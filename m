Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUJPTYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUJPTYt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUJPTYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:24:48 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:63339 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266650AbUJPTYi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:24:38 -0400
Date: Sat, 16 Oct 2004 23:24:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Kegel <dank@kegel.com>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well (was: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?)
Message-ID: <20041016212440.GA8765@mars.ravnborg.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016200627.A20488@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 08:06:27PM +0100, Russell King wrote:
> 
> Converting .S -> .s is useful for debugging - please don't cripple the
> kernel developers just because some filesystems are case-challenged.

Does the debug tools rely on files named *.s then?

There are today ~1400 files named *.S in the tree, but none named *.s.
So my idea was to do it like:
*.S => *.asm => *.o
But if this breaks some debugging tools I would like to know.

Btw. this is not about "case-challenged" filesystems in general. This is
about making the kernel usefull out-of-the-box for the increasing
embedded market.
Less work-around patces needed the better. And these people are often
bound to Windoze boxes - for different reasons. And the individual
developer may not be able to change this.

	Sam
