Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269259AbUJQS3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbUJQS3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUJQS3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:29:41 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:59369 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S269259AbUJQS3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:29:30 -0400
Date: Sun, 17 Oct 2004 20:29:29 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dan Kegel <dank@kegel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well
Message-ID: <20041017182929.GA27637@mail.13thfloor.at>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk> <20041016212440.GA8765@mars.ravnborg.org> <20041016204001.B20488@flint.arm.linux.org.uk> <20041016220427.GE8765@mars.ravnborg.org> <20041017165718.GB23525@mail.13thfloor.at> <4172A0ED.9040906@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4172A0ED.9040906@kegel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 09:42:21AM -0700, Dan Kegel wrote:
> Herbert Poetzl wrote:
> >>>>>Converting .S -> .s is useful for debugging - please don't cripple the
> >>>>>kernel developers just because some filesystems are case-challenged.
> >>>>
> >>>>Does the debug tools rely on files named *.s then?
> >>>>
> >>>>There are today ~1400 files named *.S in the tree, but none named *.s.
> >>>>So my idea was to do it like:
> >>>>*.S => *.asm => *.o
> >>>>But if this breaks some debugging tools I would like to know.
> >>>
> >>>*.asm is nonstanard naming.  If we have to support case-challenged
> >>>filesystems, please ensure that the rest of the nonbroken world can
> >>>continue as they have done for the last few decades and live happily
> >>>unaffected by these problems.
> >>
> >>I still do not see how a kernel developer are affected by changing
> >>the extension of an intermidiate file - please explain.
> >
> >hmm, maybe because they expect the output of the
> >preprocessed assembly code to have the prefix .s
> >instead of .asm (see gcc man page and play with
> >gcc -S)
> 
> The only .s/.S ambiguities that need resolving are intermediate files,
> so fixing them should only require changing a few Makefile rules.
> Let's wait and see what the patch looks like before we
> argue about it; maybe it will be simple to make everybody
> happy here (well, except those who hate the idea of
> letting anyone compile Linux kernels on Cgywin or MacOSX).

fair enough, but Mac OS X doesn't require this (UFS
is case sensititve, and probably no linux guy/gal uses 
HFS+), so IMHO it's 'just' Cygwin* folks here ...

best,
Herbert

> - Dan
> 
> 
> -- 
> Trying to get a job as a c++ developer?  See 
> http://kegel.com/academy/getting-hired.html
