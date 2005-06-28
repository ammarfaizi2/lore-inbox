Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVF1PjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVF1PjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVF1PjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:39:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45963 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262085AbVF1Pia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:38:30 -0400
Date: Tue, 28 Jun 2005 06:58:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org
Subject: Re: Kswapd flaw
Message-ID: <20050628095815.GA13464@logos.cnet>
References: <200506280637.JAA07333@raad.intranet> <42C164E1.6000506@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C164E1.6000506@grupopie.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 03:55:29PM +0100, Paulo Marques wrote:
> Al Boldi wrote:
> >On Mon, Jun 27, 2005 at 11:04:08PM +0300, Al Boldi wrote:
> >
> >>In 2.4.31 kswapd starts paging during OOMs even w/o swap enabled.
> >>
> >>Is there a way to fix/disable this behaviour?
> >
> >
> >Marcelo,
> >
> >Kswapd starts evicting processes to fullfil a malloc, when it should just
> >deny it because there is no swap.
> 
> I think what you really want is to adjust your "overcommit" settings.
> 
> See: "Documentation/vm/overcommit-accounting"

Al, 

You should set overcommit accordingly as Paulo mentions.

You might also want to disable the OOM killer (CONFIG_OOM_KILLER).

