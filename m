Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTDGXWN (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTDGXOC (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:14:02 -0400
Received: from crack.them.org ([65.125.64.184]:9696 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S263817AbTDGXFE (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 19:05:04 -0400
Date: Mon, 7 Apr 2003 19:13:21 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] detached cloning
Message-ID: <20030407231321.GA14633@nevyn.them.org>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405224233.GA12746@werewolf.able.es> <20030405230944.GG12864@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405230944.GG12864@werewolf.able.es>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 01:09:44AM +0200, J.A. Magallon wrote:
> 
> On 04.06, J.A. Magallon wrote:
> > 
> > On 04.04, Marcelo Tosatti wrote:
> > > 
> > > So here goes -pre7. Hopefully the last -pre.
> > > 
> > 
> 
> Fix a crash that can be caused by a CLONE_DETACHED thread.
> Author: Ingo Molnar <mingo@elte.hu>
> 
> Does this still apply, Ingo ?
> 
> --- linux/kernel/exit.c.orig	Mon Sep  9 14:06:05 2002
> +++ linux/kernel/exit.c	Mon Sep  9 14:06:25 2002
> @@ -369,7 +369,7 @@
>  	 *	
>  	 */
>  	
> -	if(current->exit_signal != SIGCHLD &&
> +	if(current->exit_signal != SIGCHLD && current->exit_signal != -1 &&
>  	    ( current->parent_exec_id != t->self_exec_id  ||
>  	      current->self_exec_id != current->parent_exec_id) 
>  	    && !capable(CAP_KILL))

CLONE_DETACHED isn't even in 2.4 except in Red Hat kernels.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
