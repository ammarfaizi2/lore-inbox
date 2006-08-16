Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWHPV6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWHPV6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWHPV6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:58:42 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:10700 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932275AbWHPV6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:58:41 -0400
Date: Wed, 16 Aug 2006 16:58:39 -0500
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, jklewis@us.ibm.com, arnd@arndb.de,
       Jens.Osterkamp@de.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816215839.GK20551@austin.ibm.com>
References: <44E34825.2020105@garzik.org> <20060816203043.GJ20551@austin.ibm.com> <44E38157.4070805@garzik.org> <20060816.134640.115912460.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816.134640.115912460.davem@davemloft.net>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 01:46:40PM -0700, David Miller wrote:
> From: Jeff Garzik <jeff@garzik.org>
> Date: Wed, 16 Aug 2006 16:34:31 -0400
> 
> > Linas Vepstas wrote:
> > > I was under the impression that NAPI was for the receive side only.
> > 
> > That depends on the driver implementation.
> 
> What Jeff is trying to say is that TX reclaim can occur in
> the NAPI poll routine, and in fact this is what the vast
> majority of NAPI drivers do.

I'll experiment with this.  When doing, say, an ftp, there are 
enough TCP ack packets coming back to have NAPI netdev->poll 
be called frequently enough? 

> implied.  In fact, I get the impression that spidernet is limited
> in some way and that's where all the strange approaches are coming
> from :)

Hmm. Or maybe I'm just getting old. Once upon a time, low watermarks
were considered the "best" way of doing anything; never occurred to me
it would be considered "strange".  Based on my probably obsolete idea
of what constitutes "slick hardware", I was actually impressed by what
the spidernet could do.

Aside from cleaning up the transmit ring in the receive poll loop,
what would be the not-so-strange way of doing things?

--linas


