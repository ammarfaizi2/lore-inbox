Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWAOPaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWAOPaR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 10:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAOPaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 10:30:17 -0500
Received: from h144-158.u.wavenet.pl ([217.79.144.158]:55436 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S932076AbWAOPaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 10:30:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-mm4: sem2mutex problem in USB OHCI
Date: Sun, 15 Jan 2006 16:31:35 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
References: <200601150058.58518.rjw@sisk.pl> <20060114160526.228da734.akpm@osdl.org> <20060115043826.GB23968@elte.hu>
In-Reply-To: <20060115043826.GB23968@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601151631.35450.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 15 January 2006 05:38, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  Badness in __mutex_trylock_slowpath at kernel/mutex.c:281
> > > 
> > >  Call Trace: <IRQ> <ffffffff80148d8d>{mutex_trylock+141}
> > >         <ffffffff880abaf0>{:ohci_hcd:ohci_hub_status_data+480}
> > >         <ffffffff802d25d0>{rh_timer_func+0} <ffffffff802d24c3>{usb_hcd_poll_rh_status+67}
> 
> > err, taking a mutex from softirq context.
> 
> hm. For now, the patch below undoes the struct device ->mutex 
> conversion.

That helps, thanks.

Rafael
