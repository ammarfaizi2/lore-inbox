Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWJFHEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWJFHEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWJFHEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:04:12 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:18656 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1161065AbWJFHEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:04:12 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Fri, 6 Oct 2006 09:04:51 +0200
User-Agent: KMail/1.8
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610052325.39690.oliver@neukum.org> <200610051947.44595.david-b@pacbell.net>
In-Reply-To: <200610051947.44595.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060904.51936.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Oktober 2006 04:47 schrieb David Brownell:
> On Thursday 05 October 2006 2:25 pm, Oliver Neukum wrote:
> 
> > - the issues of manual & automatic suspend and remote wakeup are orthogonal
> > - there should be a common API for all devices
> 
> AFAIK there is no demonstrated need for an API to suspend
> individual devices.  Of course there's the question of who
> would _use_ such a thing (some unspecified component, worth
> designing one first), but drivers can use internal runtime
> suspend mechanisms to be in low power modes and hide that
> fact from the rest of the system.  That is, activate on
> demand, suspend when idle.

I doubt that a lot. Eg. Again, if I close the lid I may want my USB
network cards be suspended or not and that decision might change several
times a day. It's a policy decision in many cases. And I'd not be happy
with being required to down the interfaces to do so. Suspension should
be as transparent as possible.

	Regards
		Oliver
