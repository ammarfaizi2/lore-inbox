Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751845AbWIRRBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWIRRBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 13:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWIRRBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 13:01:40 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:45562 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S1751845AbWIRRBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 13:01:39 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Michael Kerrisk'" <mtk-manpages@gmx.net>, "'Andi Kleen'" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: TCP stack behaviour question
Date: Mon, 18 Sep 2006 13:01:20 -0400
Organization: Connect Tech Inc.
Message-ID: <005501c6db44$102b73a0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <20060918153837.263210@gmx.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kerrisk [mailto:mtk-manpages@gmx.net] 
> Von: Andi Kleen <ak@suse.de>
> > On Monday 18 September 2006 16:19, Stuart MacDonald wrote:
> > > From: Andi Kleen [mailto:ak@suse.de] 
> > > > > # man 7 ip
> > > > > ..
> > > > >                Note that TCP has no error queue; 
> MSG_ERRQUEUE is
> > > > > illegal on SOCK_STREAM sockets.  Thus all errors are 
> returned by
> > > > > socket function return or SO_ERROR only.
> > > > > 
> > > > > Maybe the man page is wrong? That's from my FC 3 install.
> > > > 
> > > > The sentence is correct, but TCP has a IP_RECVERR that works
> > > > differently without a queue. Basically it doesn't delay 
> the error 
> > > > reporting for incoming ICMPs to the last retransmit, but reports
> > > > them immediately. This is documented in tcp(7)
> > > 
> > > I read that too, but didn't know which one was correct, 
> so I erred on
> > > the side of caution and believed ip(7).
> > 
> > Ok maybe it's a bit misleading. Michael, you might want to clarify.
> 
> Can some one of you propose a better text please?

Perhaps

Note that TCP has no error queue; MSG_ERRQUEUE is illegal on
SOCK_STREAM sockets.  IP_RECVERR is valid for TCP, but all errors are
returned by socket function return or SO_ERROR only.

?

..Stu

