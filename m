Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTDLHxP (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTDLHxP (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:53:15 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:44241 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263187AbTDLHxO (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 03:53:14 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Andrew Morton <akpm@digeo.com>, Tim Hockin <thockin@hockin.org>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Sat, 12 Apr 2003 10:04:56 +0200
User-Agent: KMail/1.5
Cc: sdake@mvista.com, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com, greg@kroah.com
References: <20030411150933.43fd9a84.akpm@digeo.com> <200304112219.h3BMJMG11078@www.hockin.org> <20030411154709.379a139c.akpm@digeo.com>
In-Reply-To: <20030411154709.379a139c.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304121004.56697.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Right now, if you plug and then quickly unplug a device, the unplug event
> can be handled first.
>
> It may not happen much in practice, but we have had problem with cardbus
> contact bounce causing an event storm in the past.  The daemon could just
> swallow the first 5 insert/remove pairs and process the final insert only.
>
> The kernel would have to drop messages on the floor at some point though.

That is unavoidable in _any_ scheme. The hotplug spawn scheme wishes
to weasle through this by letting kmalloc determine, when to throw away
an event. No system can process an infinite amount of events.

What's important is an ability to report loss of events and to export
a consistent view of devices connected, that can be read at will.

	Regards
		Oliver

