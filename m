Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUIOPtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUIOPtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUIOPtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:49:01 -0400
Received: from [66.35.79.110] ([66.35.79.110]:54209 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S266572AbUIOPso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:48:44 -0400
Date: Wed, 15 Sep 2004 08:48:36 -0700
From: Tim Hockin <thockin@hockin.org>
To: Karol Kozimor <kkozimor@aurox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915154836.GA4691@hockin.org>
References: <20040911165300.GA17028@kroah.com> <20040915062129.GA9230@hockin.org> <4147E525.4000405@ppp0.net> <200409151019.50592.kkozimor@aurox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409151019.50592.kkozimor@aurox.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 10:19:50AM +0200, Karol Kozimor wrote:
> On Wednesday 15 of September 2004 08:45, Jan Dittmer wrote:
> > What's wrong about fixing acpi to have something like
> > /sys/devices/acpi/buttons/power/, that spits out the event?
> > Just curious...
> 
> Well, the fact that you'd have to somehow:
> 1) pass the list of all the drivers that register notify handlers to the 
> userspace
> 2) make userspace daemons hold ~10 sysfs nodes open

I *think* the suggestion was to add sysfs nodes for ACPI objects so that
the assosicated kobject could be the "source" argument to the uevent API.
Not that each kobject would have an event stream of it's own :)

I'm not deeply into ACPI, so I'm not sure if it is possible to enumerate
all event sources, or if GPEs would come from nowhere...
