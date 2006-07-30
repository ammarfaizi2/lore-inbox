Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWG3HLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWG3HLP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 03:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWG3HLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 03:11:14 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:19910 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751226AbWG3HLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 03:11:14 -0400
Date: Sun, 30 Jul 2006 00:11:13 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Linus Torvalds <torvalds@osdl.org>
cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-dvb-maintainer@linuxtv.org, akpm@osdl.org,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH 00/23] V4L/DVB fixes
In-Reply-To: <Pine.LNX.4.64.0607292300070.4168@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0607292352490.32415@shell2.speakeasy.net>
References: <20060725180311.PS54604900000@infradead.org> <1154222716.27019.39.camel@praia>
 <Pine.LNX.4.64.0607292300070.4168@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2006, Linus Torvalds wrote:
> On Sat, 29 Jul 2006, Mauro Carvalho Chehab wrote:
> >
> > Please pull these (and the other ones) from master branch at:
> >         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
>
> I get a _huge_ diffstat with
>
>  135 files changed, 3056 insertions(+), 1562 deletions(-)

There are mostly two things which did this.

One is that Mauro translated almost all of the V4L1 radio card drivers to
V4L2.  The changes are all very repetitive, but it made a huge diffstat:

 15 files changed, 1758 insertions(+), 918 deletions(-)

The second source is the dvb_attach() system, which was not supposed to go
in 2.6.18, it was for 2.6.19.

 74 files changed, 827 insertions(+), 622 deletions(-)

The dvb_attach() stuff isn't ready for 2.6.18, it hasn't been tested at all
and it's a very significant change.  The ISA radio card drivers....  I
don't think they are used very much anymore.
