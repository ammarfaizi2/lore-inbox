Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTE0Wpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264403AbTE0Wpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:45:50 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:15268 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264405AbTE0Wpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:45:46 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 27 May 2003 15:58:48 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Thomas Winischhofer <thomas@winischhofer.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x
In-Reply-To: <3ED3ECC4.4040407@winischhofer.net>
Message-ID: <Pine.LNX.4.55.0305271555270.1362@bigblue.dev.mcafeelabs.com>
References: <3ED21CE3.9060400@winischhofer.net> 
 <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com> 
 <3ED32BA4.4040707@winischhofer.net>  <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com>
 <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk> <3ED3CDA9.5090605@winischhofer.net>
 <Pine.LNX.4.55.0305271519210.1362@bigblue.dev.mcafeelabs.com>
 <3ED3ECC4.4040407@winischhofer.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Thomas Winischhofer wrote:

> Davide Libenzi wrote:
> > It does not look right to me either to poke the IDE controller. Another
> > solution might be to parse the routing table and gather informations from
> > there. Example, the findings of 0x61,...,0x63 will tell us that we're
> > dealing with newer chipsets that uses those for values for the 3 OHCI and
> > the EHCI.
>
> (The "plain" 650 [with 961] has no EHCI; this was introduced with the 962)

It still has 0x60...0x63 values in the routing table (looking at your
files).


>  > The revision ID trick seems not effective, at least looking at
> > your machine with rev-id 0 that has 0x61..63. Martin, was the revision id
> > 0, that you suggested to be handled with the old router, minded ?
>
> What about gathering all that info from the routing table? Please excuse
> this perhaps naive assumption, but isn't that what's it's good for?

That's what's I'm telling ;) Now (in my office) I do not have the machine
to play with (personal laptop) but tonight I'll make a patch that will use
the routing table info to discover the appropriate router selection.



- Davide

