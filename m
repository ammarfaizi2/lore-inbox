Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbULIAjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbULIAjd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 19:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbULIAjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 19:39:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10387 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261417AbULIAjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 19:39:21 -0500
Date: Thu, 9 Dec 2004 11:39:06 +1100
From: Greg Banks <gnb@sgi.com>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: Greg Banks <gnb@sgi.com>, John Levon <levon@movementarian.org>,
       Akinobu Mita <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041209003906.GE4239@sgi.com>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041208160055.GA82465@compsoc.man.ac.uk> <20041208223156.GB4239@sgi.com> <20041208235623.GA563@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208235623.GA563@zaniah>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 12:56:23AM +0100, Philippe Elie wrote:
> 
> oprofile_timer_init doesn't reset op->setup/shutdown, I don't like the idea to
> reset them in oprofile_timer_init() it's error prone. John any idea ?

A better long term solution would be not to change the ops structure
but to copy and chain it, as I did in my experimental cswitch patches.
The approach I took allows for a new fake event which can be selected
at runtime with --event instead of with a boot option.

But for now I don't see any drama with leaving in the ->setup() and
->shutdown() methods when rewriting the ops structure.  Ditto for
the ->create_files() methods.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
