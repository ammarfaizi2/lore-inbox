Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTEJU7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbTEJU7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:59:24 -0400
Received: from crack.them.org ([146.82.138.56]:9856 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S264506AbTEJU7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:59:23 -0400
Date: Sat, 10 May 2003 17:11:54 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Adam Majer <adamm@galacticasoftware.com>
Cc: Bernhard Kaindl <bk@suse.de>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ptrace secfix does NOT work... :(
Message-ID: <20030510211154.GA4559@nevyn.them.org>
Mail-Followup-To: Adam Majer <adamm@galacticasoftware.com>,
	Bernhard Kaindl <bk@suse.de>, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <Pine.LNX.4.44.0305082310230.12720-200000@wotan.suse.de> <20030510205249.GA1179@galacticasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510205249.GA1179@galacticasoftware.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 03:52:49PM -0500, Adam Majer wrote:
> On Fri, May 09, 2003 at 12:05:52AM +0200, Bernhard Kaindl wrote:
> > Hello,
> > 
> > The attached patch cleans up the too restrictive checks which were
> > included in the original ptrace/kmod secfix posted by Alan Cox
> > and applies on top of a clean 2.4.20-rc1 source tree.
> 
> But the ptrace hole is _NOT_ fixed... :(

This is the exploit which makes itself suid.  Did you leave it suid
before retesting it?

> adamm@polaris:~/test$ uname -r
> 2.4.21-rc2
> \u@\h:\w\$ ls -ltr hehe
> -rw-------    1 root     root           17 May 10 15:44 hehe
> \u@\h:\w\$ whoami
> root
> \u@\h:\w\$ cat hehe
> I can see you!!
>                                                                                                               
> \u@\h:\w\$ rm hehh
> \u@\h:\w\$ ls -ltr hehe
> ls: hehe: No such file or directory

Huh?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
