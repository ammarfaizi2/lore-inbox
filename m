Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbULHQBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbULHQBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbULHQBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:01:15 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:3855 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id S261247AbULHQBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:01:00 -0500
Date: Wed, 8 Dec 2004 16:00:55 +0000
From: John Levon <levon@movementarian.org>
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
Cc: phil.el@wanadoo.fr, linux-kernel@vger.kernel.org, gnb@melbourne.sgi.com
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041208160055.GA82465@compsoc.man.ac.uk>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412081830.51607.amgta@yacht.ocn.ne.jp>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Cc4FL-00049Q-P3*9fDvRd/lwmY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 06:30:51PM +0900, Akinobu Mita wrote:

> When I forced the oprofile to use timer interrupt with specifying
> "timer=1" module parameter. "oprofile_operations->backtrace" did
> not initialized on i386.
> 
> Please apply this patch, or make oprofile initialize the backtrace
> operation in case of using timer interrupt in your preferable way.

I don't like this patch. The arches should just set the backtrace
always, then try to init the hardware. oprofile_init() should then force
the timer ops as needed.

Greg?

john
