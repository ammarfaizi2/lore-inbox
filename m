Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270863AbTGPOZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270872AbTGPOZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:25:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3206 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270863AbTGPOZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:25:09 -0400
Date: Wed, 16 Jul 2003 10:42:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SUID root
In-Reply-To: <20030716142249.GA22473@nevyn.them.org>
Message-ID: <Pine.LNX.4.53.0307161040570.26405@chaos>
References: <Pine.LNX.4.53.0307161017060.26254@chaos> <20030716142249.GA22473@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003, Daniel Jacobowitz wrote:

> On Wed, Jul 16, 2003 at 10:19:14AM -0400, Richard B. Johnson wrote:
> >
> > It appears as though SUID root programs don't work on
> > linux 2.4.20, 2.4.21, or 2.4.22-pre6, or at least what
> > used to work no longer does.
> >
> > One program tries to execute iopl(3). In the event that
> > it fails, it tries to set UID/GID to root after saving
> > the previous, then tries again.
> >
> > The program exists in /usr/bin, properly owned by root. It
> > is set SUID, 4755, and otherwise works. Anybody have any
> > clues? Do SUID programs have to be re-written to use some
> > other mechanism? I need to have a user-mode program get
> > access to an otherwise unused printer port. It's a shame
> > to write a module just for this.
>
> You're stracing it.  Stracing prevents setuid from occurring; it used
> to just prevent the exec.
>

Okay. Thanks, you are right. It is actually working I guess.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.3% of all statistics are fiction.

