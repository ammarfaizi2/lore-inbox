Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTFDHq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 03:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTFDHq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 03:46:57 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:26513 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263103AbTFDHq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 03:46:56 -0400
Date: Wed, 4 Jun 2003 10:00:17 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-yoann@ifrance.com, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       acahalan@cs.uml.edu
Subject: Re: another must-fix: major PS/2 mouse problem
Message-ID: <20030604100017.A5475@ucw.cz>
References: <1054431962.22103.744.camel@cube> <3EDD87FD.6020307@ifrance.com> <20030603232155.1488c02f.akpm@digeo.com> <20030604094737.C5345@ucw.cz> <20030604005302.41f3b0b8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030604005302.41f3b0b8.akpm@digeo.com>; from akpm@digeo.com on Wed, Jun 04, 2003 at 12:53:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 12:53:02AM -0700, Andrew Morton wrote:
> Vojtech Pavlik <vojtech@ucw.cz> wrote:
> >
> > On Tue, Jun 03, 2003 at 11:21:55PM -0700, Andrew Morton wrote:
> > 
> > > We believe that it may be due to the ethernet driver holding interrupts off
> > > for too long when the traffic is heavy.
> > 
> > Note that this doesn't necessarily mean that the ethernet driver
> > disables the interrupts for a too long time, it just means that the
> > computer is only servicing the network interrupts at that time, and
> > since the mouse interrupt does have a lower priority, it's serviced
> > not very often and with huge delays.
> > 
> > In such a case the network driver should either use interrupt mitigation
> > if the cards supports it (reading many packets per one interrupt) or
> > switch to a polled mode.
> 
> Has this problem been observed in 2.4 kernels?

No, since 2.4 doesn't have the re-sync code in the mouse driver which is
triggering in this case. But problems with the machine being flooded
with interrupts from the NIC so hard that it actually cannot do anything
are quite common.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
