Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbTCYNsy>; Tue, 25 Mar 2003 08:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbTCYNsD>; Tue, 25 Mar 2003 08:48:03 -0500
Received: from crack.them.org ([65.125.64.184]:19334 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262651AbTCYNrS>;
	Tue, 25 Mar 2003 08:47:18 -0500
Date: Tue, 25 Mar 2003 08:58:02 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: raj <raj@cs.wisc.edu>, linux-kernel@vger.kernel.org, zandy@cs.wisc.edu
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
Message-ID: <20030325135802.GA13406@nevyn.them.org>
Mail-Followup-To: Werner Almesberger <wa@almesberger.net>,
	raj <raj@cs.wisc.edu>, linux-kernel@vger.kernel.org,
	zandy@cs.wisc.edu
References: <1047936295.3e763d273307c@www-auth.cs.wisc.edu> <20030324040908.GA19754@nevyn.them.org> <3E7EA4B2.5010306@cs.wisc.edu> <20030324150552.GA26287@nevyn.them.org> <20030325104842.A7468@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325104842.A7468@almesberger.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:48:42AM -0300, Werner Almesberger wrote:
> Daniel Jacobowitz wrote:
> > No, that's not what I meant.  When you attach using GDB, there is no
> > way for GDB to determine if the process was previously stopped or
> > running.
> 
> Likewise, there's a race condition with any other concurrent use
> of SIGSTOP.
> 
> Perhaps one could introduce a PTRACE_ATTACH2 that uses "addr" to
> indicate the signal that should be used to sychronize attaching.
> That way, programs that use STOP/CONT for their own purposes could
> be attached to with ptrace(PTRACE_ATTACH2,pid,SIGTRAP,0), or such.
> 
> If the process is already stopped, the debugger would be notified
> with WSTOPSIG set to that signal instead of SIGTRAP.

Have you got an example that needs this?  I'm not terribly concerned;
GDB's handling of SIGSTOP has always been pretty bad.  Strace is a bit
better.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
