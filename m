Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUGOICe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUGOICe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 04:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUGOIC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 04:02:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.191]:23550 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266138AbUGOICN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 04:02:13 -0400
To: =?iso-8859-1?Q?William_Lee_Irwin_III?= <wli@holomorphy.com>
Subject: =?iso-8859-1?Q?Re:_[PATCH]_was:_[RFC]_removal_of_sync_in_panic?=
From: <linux-kernel@borntraeger.net>
Cc: <linux-kernel@borntraeger.net>, <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?Andrew_Morton?= <akpm@osdl.org>, <lmb@suse.de>
Message-Id: <5636222$108987797940f637db66fab3.01183982@config19.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 5636222
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Thu, 15 Jul 2004 10:00:01 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.146
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


William Lee Irwin III <wli@holomorphy.com> schrieb am 15.07.2004,
09:27:34:
> William Lee Irwin III  schrieb am 15.07.2004, 
> >> I've seen SMP boxen run interrupt handlers for ages after 
> >> panicking, but I never thought much of it.

> > I have seen more than just interupt handlers.I was able to log in  > > via ssh. After typing dmesg I saw 2 panics and the system was
> > still up.

> Jesus fscking H. Christ wtf is going on here?

It was a 4 cpu box. 2 cpus have been busy trying to sync. Therefore, 2
cpus were still able to do some work including ssh and bash. That was
the reason why I proposed to remove sync out of panic.
