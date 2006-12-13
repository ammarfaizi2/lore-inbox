Return-Path: <linux-kernel-owner+w=401wt.eu-S1751611AbWLMRo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWLMRo5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWLMRo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:44:56 -0500
Received: from dxv01.wellsfargo.com ([151.151.5.42]:45116 "EHLO
	dxv01.wellsfargo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbWLMRoz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:44:55 -0500
X-Greylist: delayed 2849 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 12:44:55 EST
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Interphase Tachyon drivers missing.
Date: Wed, 13 Dec 2006 10:51:29 -0600
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D023BAE21@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Interphase Tachyon drivers missing.
Thread-Index: AccelxzPaqeyJzUlQkWqaB3ueAcqNQAP1Bkg
From: <Greg.Chandler@wellsfargo.com>
To: <eike-kernel@sf-tec.de>
Cc: <linux-kernel@vger.kernel.org>, <mkp@mkp.net>
X-OriginalArrivalTime: 13 Dec 2006 16:51:30.0247 (UTC) FILETIME=[F00B8570:01C71ED6]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure about the driver being cpqfc, I know in 2.6.0 & 1 the
driver was definitely iphase.c/h/o
I do know the chipset was used by almost everyone, Compaq/HP/DEC and
Interphase's namebrand cards.

I also know that the driver is still working in 2.4.33 my slackware 11
default kernel picked up the card, which suprised me to say the least...
I won't have time to spend a weekend on it until about christmas. {or
probably christmas day is more likely} Even then I can't make any kind
of promise that I can do anything useful about it...


-----Original Message-----
From: Rolf Eike Beer [mailto:eike-kernel@sf-tec.de] 
Sent: Wednesday, December 13, 2006 3:14 AM
To: Chandler, Greg
Cc: linux-kernel@vger.kernel.org; Martin K. Petersen
Subject: Re: Interphase Tachyon drivers missing.

Greg.Chandler@wellsfargo.com wrote:
> I went to upgrade my kernel on a couple of boxes yesterday and noticed

> that the Interphase Tachyon chipset Fibre Channel driver was removed 
> from the kernel.  I think 2.6.1 was the last one it was still in.  Was

> there a reason it was pulled?
> If not, do I have to volunteer to put it back in or can someone with 
> more skill re-add it?

I suppose you're talking about the cpqfc driver? I have tried to clean
it up but gave up. Next try was to rewrite, but due to lack of time
there is no progress in the last month. The old driver was that horrible
coded that noone can maintain it. It was originally written for
something like Linux 2.2 and was never even forward ported completely to
2.4. With the major changes in Linux' driver model that went into 2.6 it
was nearly unusable anyway. Not that the use of it in 2.4 can be
encouraged. One of the main problems is the severe lack of error
handling which you can see alone from the fact that there are tons of
function returning void even in the critical I/O-path's.

I have heard of at least 3 different people before you (not counting me)
that would like to have a driver for this one. One even donated some
hardware to me around last christmas. But nevertheless my lack of time
stopped my work on this.

Martin, you were hacking on something there too but never showed up some
code. 
Is there anything new?

Eike

