Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVK1UdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVK1UdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVK1UdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:33:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:10216 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S932240AbVK1UdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:33:23 -0500
Date: Mon, 28 Nov 2005 21:33:07 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: s_maxbytes on isofs for 2.4
Message-ID: <20051128203307.GB17879@apps.cwi.nl>
References: <200511272123.jARLNeA03057@apps.cwi.nl> <20051128134643.GB25081@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128134643.GB25081@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 11:46:43AM -0200, Marcelo Tosatti wrote:

> > I got a problem report on the handling of large (2.4GB) files
> > with isofs, where 2.6 was fine and 2.4 failed. Replied
> > 
> > >I suspect that the difference between 2.4 and 2.6 is the assignment
> > >       s->s_maxbytes = 0xffffffff;
> > >in isofs/inode.c. Could you try to add that after
> > >       s->s_magic = ISOFS_SUPER_MAGIC;
> > >in the 2.4 source?
> > 
> > and got the confirmation that that solves the problems.
> > Maybe one should consider adding this in 2.4.
> 
> I can't spot any issues with files upto 4GB.
> Who was the reporter?

Giulio Orsero <giulioo \x40 pobox \x2e com>
