Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbTDJPBU (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 11:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbTDJPBU (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 11:01:20 -0400
Received: from crack.them.org ([65.125.64.184]:42887 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S264062AbTDJPBT (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 11:01:19 -0400
Date: Thu, 10 Apr 2003 11:12:48 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] detached cloning
Message-ID: <20030410151248.GA11647@nevyn.them.org>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405224233.GA12746@werewolf.able.es> <20030405230944.GG12864@werewolf.able.es> <20030407231321.GA14633@nevyn.them.org> <20030409232931.GA15917@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030409232931.GA15917@werewolf.able.es>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 01:29:31AM +0200, J.A. Magallon wrote:
> 
> On 04.08, Daniel Jacobowitz wrote:
> > On Sun, Apr 06, 2003 at 01:09:44AM +0200, J.A. Magallon wrote:
> > > 
> > > On 04.06, J.A. Magallon wrote:
> > > > 
> > > > On 04.04, Marcelo Tosatti wrote:
> > > > > 
> > > > > So here goes -pre7. Hopefully the last -pre.
> > > > > 
> > > > 
> > > 
> > > Fix a crash that can be caused by a CLONE_DETACHED thread.
> > > Author: Ingo Molnar <mingo@elte.hu>
> > > 
> [...]
> > 
> > CLONE_DETACHED isn't even in 2.4 except in Red Hat kernels.
> > 
> 
> But pthreads can spawn detached threads. Can this have any effect ?

Detached threads actually have no relationship to CLONE_DETACHED.  In
NPTL all threads are CLONE_DETACHED whether they're detached or not; in
LinuxThreads they never are, also regardless.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
