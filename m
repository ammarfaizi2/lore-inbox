Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270713AbTHSOg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbTHSOea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:34:30 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:11191
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id S270663AbTHSOcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:32:50 -0400
Date: Tue, 19 Aug 2003 07:32:49 -0700
From: Phil Oester <kernel@theoesters.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] Ratelimit SO_BSDCOMPAT warnings
Message-ID: <20030819073249.A26949@ns1.theoesters.com>
References: <20030818150605.A23957@ns1.theoesters.com> <200308182215.h7IMFecc013449@turing-police.cc.vt.edu> <20030818154800.21ae818e.davem@redhat.com> <20030819003633.GC11081@mail.jlokier.co.uk> <20030819010550.GF11081@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030819010550.GF11081@mail.jlokier.co.uk>; from jamie@shareable.org on Tue, Aug 19, 2003 at 02:05:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Admittedly, recompiling Bind after commenting out the #define from
asm/socket.h does also solve the errors.  But it does seem overkill
to warn on every single use of this...

Phil

On Tue, Aug 19, 2003 at 02:05:50AM +0100, Jamie Lokier wrote:
> Jamie Lokier wrote:
> > David S. Miller wrote:
> > > I see no reason to apply this, just fix your apps and the
> > > warning will stop.  There's only a handful of programs
> > > that trigger this at all.
> > 
> > Unfortunately Red Hat's BIND is among the more prominent. :-/
> 
> Sorry, I didn't mean to imply _just_ Red Hat.  Probably all distros'
> BINDs use SO_BSDCOMPAT.  What I meant was this is the only program I
> notice the warning from, when running a 2.5 kernel on an otherwise Red
> Hat 9 system.  And it comes up every time I connect to the net, when I
> restart named with new forwarders, which is about hourly :/
> 
> -- Jamie
