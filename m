Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTJaNCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTJaNCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:02:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8353 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263294AbTJaNCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:02:13 -0500
Date: Fri, 31 Oct 2003 14:02:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, sluskyb@paranoiacs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-ID: <20031031130208.GJ7314@suse.de>
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <3FA25246.16257890@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA25246.16257890@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31 2003, Jari Ruusu wrote:
> Andrew Morton wrote:
> > Jari Ruusu <jariruusu@users.sourceforge.net> wrote:
> > > Cryptoapi interface is quite broken. Your change extends that breakage to
> > > loop transfer interface. Please don't do that.
> > 
> > Please describe this breakage.
> 
> It is broken because it includes kmaps. kmaps may be required evil thing
> that is currectly required, but in long term kmaps deserve fate of DOS EMS.
> Less interfaces that include that damage, the better. Please don't include
> that damage in loop transfer interface.

Bouncing is better?! Get real.

An interface based on page,len,offset is so much better than a virtual
address. It works equally well on sane archs as insane ones.

-- 
Jens Axboe

