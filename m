Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271327AbTGWVER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271325AbTGWVEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:04:16 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:41989 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S271324AbTGWVEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:04:15 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.5] fixes for airo.c
Date: Wed, 23 Jul 2003 23:19:54 +0200
User-Agent: KMail/1.5.2
Cc: Javier Achirica <achirica@telefonica.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
References: <Pine.SOL.4.30.0307231219020.12179-100000@tudela.mad.ttd.net> <200307231956.58656.daniel.ritz@gmx.ch> <20030723204304.GA1929@gtf.org>
In-Reply-To: <20030723204304.GA1929@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307232319.54741.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed July 23 2003 22:43, Jeff Garzik wrote:
> On Wed, Jul 23, 2003 at 07:56:58PM +0200, Daniel Ritz wrote:
> > [shortening the cc: list a bit..]
> > 
> > On Wed July 23 2003 12:26, Javier Achirica wrote:
> > > 
> > > You cannot use down() in xmit, as it may be called in interrupt context. I
> > > know it slows things down, but that's the only way I figured out of
> > > handling a transmission while the card is processing a long command.
> > 
> > hu? no. you can do a down() as xmit is never called from interrupt context. and
> > the dev->hard_start_xmit() calls are serialized with the dev->xmit_lock. the
> > serialization is broken by the schedule_work() thing.
> 
> hard_start_xmit is called from BH-disabled context, so Javier is
> basically correct.

hmm...sorry for making noise...i really should read more of the kernel/networking code.
javier, then please send your latest (1.53) diff to jeff and i'm shuting up.
 

-daniel

