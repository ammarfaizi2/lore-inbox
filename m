Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUJQQ53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUJQQ53 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUJQQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:57:28 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:27624 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266117AbUJQQ5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:57:19 -0400
Date: Sun, 17 Oct 2004 18:57:18 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dan Kegel <dank@kegel.com>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well (was: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?)
Message-ID: <20041017165718.GB23525@mail.13thfloor.at>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk> <20041016212440.GA8765@mars.ravnborg.org> <20041016204001.B20488@flint.arm.linux.org.uk> <20041016220427.GE8765@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016220427.GE8765@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 12:04:27AM +0200, Sam Ravnborg wrote:
> On Sat, Oct 16, 2004 at 08:40:01PM +0100, Russell King wrote:
> > On Sat, Oct 16, 2004 at 11:24:40PM +0200, Sam Ravnborg wrote:
> > > On Sat, Oct 16, 2004 at 08:06:27PM +0100, Russell King wrote:
> > > > 
> > > > Converting .S -> .s is useful for debugging - please don't cripple the
> > > > kernel developers just because some filesystems are case-challenged.
> > > 
> > > Does the debug tools rely on files named *.s then?
> > > 
> > > There are today ~1400 files named *.S in the tree, but none named *.s.
> > > So my idea was to do it like:
> > > *.S => *.asm => *.o
> > > But if this breaks some debugging tools I would like to know.
> > 
> > *.asm is nonstanard naming.  If we have to support case-challenged
> > filesystems, please ensure that the rest of the nonbroken world can
> > continue as they have done for the last few decades and live happily
> > unaffected by these problems.
> 
> I still do not see how a kernel developer are affected by changing
> the extension of an intermidiate file - please explain.

hmm, maybe because they expect the output of the
preprocessed assembly code to have the prefix .s
instead of .asm (see gcc man page and play with
gcc -S)

GCC(1)                      GNU Tools                      GCC(1)

       .s    Assembler source; assemble
       .S    Assembler source; preprocess, assemble

best,
Herbert

> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
