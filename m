Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTDDSBe (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbTDDSBd (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:01:33 -0500
Received: from havoc.daloft.com ([64.213.145.173]:22145 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263802AbTDDSBb (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:01:31 -0500
Date: Fri, 4 Apr 2003 13:12:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keep de2104x quiet
Message-ID: <20030404181256.GA26315@gtf.org>
References: <wrpsmsydtv2.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpsmsydtv2.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 08:01:53PM +0200, Marc Zyngier wrote:
> Jeff,
> 
> The included patch tries to keep the de2104x driver quiet if there is
> link change. Without this patch, I'm getting lots of :
> 
> eth0: link up, media 10baseT-HD
> eth0: link up, media 10baseT-HD
> eth0: link up, media 10baseT-HD
> 
> about one a minute... Quite annoying. With this patch, the driver only
> logs when state changes (which is already taken care of in
> de_link_up()).

Note the netif_msg_timer() test.  Just remove that bit from the
default message bit settings.

	Jeff



