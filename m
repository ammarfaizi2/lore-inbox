Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTDLHhU (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTDLHhU (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:37:20 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:33462 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263183AbTDLHhT (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 03:37:19 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Sat, 12 Apr 2003 09:49:00 +0200
User-Agent: KMail/1.5
Cc: Steven Dake <sdake@mvista.com>, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
References: <20030411172011.GA1821@kroah.com> <20030411150933.43fd9a84.akpm@digeo.com> <20030411230111.GF3786@kroah.com>
In-Reply-To: <20030411230111.GF3786@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304120949.00709.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And yes, we could use ascii in the event list, but then again, a
> userspace version of /sbin/hotplug that writes events to a pipe that is
> read from a daemon enables the same thing to happen :)

No, it doesn't. You throw away the ordering the kernel naturally has.
If you write out events from within the kernel, you know that you'll
never see a replug before an unplug.

Writing a pipe from the kernel, which is generally called a character
device, has other advantages as well.
You can report events dropped as errors. The hotplug spawning
scheme cannot do that. No spawning cannot differentiate between
no event and an event lost.

	Regards
		Oliver

