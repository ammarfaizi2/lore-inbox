Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUIOQ0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUIOQ0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUIOQNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:13:46 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:37018
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S266725AbUIOQMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:12:12 -0400
Message-ID: <414869CE.3050208@ppp0.net>
Date: Wed, 15 Sep 2004 18:11:58 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Karol Kozimor <kkozimor@aurox.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
References: <20040911165300.GA17028@kroah.com> <20040915062129.GA9230@hockin.org> <4147E525.4000405@ppp0.net> <200409151019.50592.kkozimor@aurox.org> <20040915154836.GA4691@hockin.org>
In-Reply-To: <20040915154836.GA4691@hockin.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> On Wed, Sep 15, 2004 at 10:19:50AM +0200, Karol Kozimor wrote:
> 
>>On Wednesday 15 of September 2004 08:45, Jan Dittmer wrote:
>>
>>>What's wrong about fixing acpi to have something like
>>>/sys/devices/acpi/buttons/power/, that spits out the event?
>>>Just curious...
>>
>>Well, the fact that you'd have to somehow:
>>1) pass the list of all the drivers that register notify handlers to the 
>>userspace
>>2) make userspace daemons hold ~10 sysfs nodes open
> 
> 
> I *think* the suggestion was to add sysfs nodes for ACPI objects so that
> the assosicated kobject could be the "source" argument to the uevent API.
> Not that each kobject would have an event stream of it's own :)

Yepp.

> I'm not deeply into ACPI, so I'm not sure if it is possible to enumerate
> all event sources, or if GPEs would come from nowhere...

Well if you do a find /sys | grep acpi, there are basically all nodes
already there - just no values in there :-(
I think Andrew's suggestions (in this same thread) make more sense, ie.
deliver button events via the input layer...

Jan
