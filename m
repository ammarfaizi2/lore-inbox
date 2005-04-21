Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVDUS6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVDUS6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVDUS6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:58:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5519 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261766AbVDUS6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:58:20 -0400
Date: Thu, 21 Apr 2005 20:46:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nathan Lynch <ntl@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] generate hotplug events for cpu online
Message-ID: <20050421184655.GA475@openzaurus.ucw.cz>
References: <20050414175623.GB12960@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414175623.GB12960@otto>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We already do kobject_hotplug for cpu offline; this adds a
> kobject_hotplug call for the online case.  This is being requested by
> developers of an application which wants to be notified about both
> kinds of events.

I'm afraid of bad interactions with swsusp/S3 on smp. We offline cpus there,
but we probably do not want userland to know...

				Pavel


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

