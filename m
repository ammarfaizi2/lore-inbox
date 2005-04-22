Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVDVATE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVDVATE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVDVARR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:17:17 -0400
Received: from orb.pobox.com ([207.8.226.5]:39657 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261749AbVDVAPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:15:15 -0400
Date: Thu, 21 Apr 2005 19:15:06 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] generate hotplug events for cpu online
Message-ID: <20050422001506.GB18688@otto>
References: <20050414175623.GB12960@otto> <20050421184655.GA475@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421184655.GA475@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 08:46:56PM +0200, Pavel Machek wrote:
> Hi!
> 
> > We already do kobject_hotplug for cpu offline; this adds a
> > kobject_hotplug call for the online case.  This is being requested by
> > developers of an application which wants to be notified about both
> > kinds of events.
> 
> I'm afraid of bad interactions with swsusp/S3 on smp. We offline cpus there,
> but we probably do not want userland to know...

The kobject_hotplug calls for cpu online and offline are present only
in the code paths where the operation is initiated through the sysfs
interface, so I don't think you have to worry.

Nathan
