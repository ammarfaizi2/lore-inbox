Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbUFWPUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUFWPUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUFWPUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:20:33 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:9629 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S265125AbUFWPUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:20:31 -0400
Subject: Re: PATCH: Precise Accounting for 2.6.7
From: Timm Morten Steinbeck <timm.steinbeck@kip.uni-heidelberg.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org,
       Arne Wiebalck <wiebalck@kip.uni-heidelberg.de>
In-Reply-To: <m33c4m495d.fsf@averell.firstfloor.org>
References: <2ah51-6Va-35@gated-at.bofh.it>
	 <m33c4m495d.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1088004016.3630.7.camel@ts2.kip.uni-heidelberg.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 23 Jun 2004 17:20:16 +0200
Content-Transfer-Encoding: 7bit
X-SA-Relays-Trusted: [ ip=129.206.177.159 rdns=ts2.kip.uni-heidelberg.de helo=ts2.kip.uni-heidelberg.de by=mail.kip.uni-heidelberg.de ident= ]
X-SA-Relays-Untrusted: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mit, 2004-06-23 um 16.54 schrieb Andi Kleen:
> Timm Morten Steinbeck <timm.steinbeck@kip.uni-heidelberg.de> writes:
> 
> > Hi,
> >
> > we have ported our x86 precise accounting patch from the 2.4 kernel
> > series to 2.6.7.
> 
> [...]
> 
> On many SMP systems it will not be very precise after longer uptimes
> because the TSCs of the CPUs drift away noticeable and timestamps
> from different CPUs cannot be really compared.

As far as we understand the problem you describe we do not see this as a
problem.
The patch keeps track of the TSCs of each CPU separately and only uses
the differences of values read on the same CPU. At least that was our
intention, but maybe we overlooked something. Can you point us to the
places in our patch where this problem occurs?

Best regards
  Arne & Timm

********************************************************************
 Timm M. Steinbeck &                Kirchhoff Institute for Physics
 Arne Wiebalck                Computer Science/Computer Engineering
 e-mail:                                        INF 227, Room 3.315
 timm.steinbeck AT kip.uni-heidelberg.de         D-69120 Heidelberg
 arne.wiebalck AT kip.uni-heidelberg.de
 web:                                      Tel.: (+49) 6221/54-9816
 http://www.kip.uni-heidelberg.de          Fax.: (+49) 6221/54-9809
********************************************************************


