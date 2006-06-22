Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWFVTwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWFVTwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWFVTwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:52:22 -0400
Received: from gw.goop.org ([64.81.55.164]:26848 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932642AbWFVTwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:52:21 -0400
Message-ID: <449AF500.7000106@goop.org>
Date: Thu, 22 Jun 2006 12:52:32 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       ntl@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com> <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain> <20060622084513.4717835e.rdunlap@xenotime.net> <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com> <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com> <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz>
In-Reply-To: <20060622182231.GC4193@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> That's what I'd prefer... as swsusp uses cpu hotplug.

Does it have to?  I presume this has been considered before, but what if 
the other CPUs were just idled for suspend rather than "removed"?  Or do 
you actually need to simulate a hot-remove to make sure they get 
suspended properly?  In general, the "hot remove as suspend" thing seems 
semantically awkward.

    J
