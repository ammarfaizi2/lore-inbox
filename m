Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbUJ1BVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbUJ1BVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUJ1BVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:21:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262621AbUJ1BUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:20:33 -0400
Date: Wed, 27 Oct 2004 18:19:40 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "O.Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org,
       davej@redhat.com, Russell King <rmk+lkml@arm.linux.org.uk>,
       jgarzik@pobox.com, tglx@linutronix.de,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, zaitcev@redhat.com,
       <rwhite@casabyte.com>
Subject: Re: Linux 2.4.28-rc1
Message-ID: <20041027181940.7b27170b@lembas.zaitcev.lan>
In-Reply-To: <20041026203334.GB29688@logos.cnet>
References: <417E5904.9030107@ttnet.net.tr>
	<20041026203334.GB29688@logos.cnet>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 18:33:34 -0200, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> > - Robert White: usbserial hangup on disconnect
> >   http://marc.theaimsgroup.com/?t=108114071200002&r=1&w=2
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=108114073600529&w=2
> > 
> > - V Ganesh: ipaq, hangup tty on usb disconnect
> >   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=109049411609590&w=2
> 
> Pete, can you take a look at these?

I already did, I just keep procrastinating. Better is an enemy of good.
I wanted to adopt 2.6 style refcounting, because there's a possibility
of oops lurking in 2.4 code. That would move the hangup call into the
close/release path.

The top part of V. Ganesh's patch with a missing initialization you already
have in -rc1. The bottom part Robert's patch covers (modulo the relocation
of the whole fragment).

I'll make a better 2.6 style patch as soon as I can. Maybe today even.

-- Pete
