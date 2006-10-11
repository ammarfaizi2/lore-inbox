Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbWJKUcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbWJKUcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWJKUcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:32:12 -0400
Received: from xenotime.net ([66.160.160.81]:15039 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161246AbWJKUcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:32:10 -0400
Date: Wed, 11 Oct 2006 13:33:37 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Cc: "Alexey Dobriyan" <adobriyan@gmail.com>,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: misused local_irq_disable() in analog.c?
Message-Id: <20061011133337.5d78ace5.rdunlap@xenotime.net>
In-Reply-To: <d120d5000610111317k4e849707rc358fdd4ad5dae5b@mail.gmail.com>
References: <b6fcc0a0610111208s4dbb7c98xbdd3ceb13fba1503@mail.gmail.com>
	<d120d5000610111317k4e849707rc358fdd4ad5dae5b@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 16:17:33 -0400 Dmitry Torokhov wrote:

> On 10/11/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > Dmitry, take a look at analog_cooked_read():
> >
> > do-while loop there contains local_irq_disable()/local_irq_restore(flags);
> > which aren't complement.
> >
> > Should it be
> >
> >    local_irq_save(flags);
> >    this = gameport_read(gameport) & port->mask;
> >    GET_TIME(now);
> >    local_irq_restore(flags);
> >
> > ?
> 
> Yep, I think so. Patch?

Alexey replied on another thread (Re: [PATCH] misuse of strstr):

"sorry for absence of patch, I'm on wonders of BY dial-up _and_ Gmail
web interface right now."


---
~Randy
