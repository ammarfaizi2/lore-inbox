Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUGZUsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUGZUsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUGZUkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:40:23 -0400
Received: from peabody.ximian.com ([130.57.169.10]:31393 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265920AbUGZUKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:10:38 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: linux-kernel@tux.tmfweb.nl
Cc: dsaxena@plexity.net, Michael Clark <michael@metaparadigm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040726200802.GA9144@nospam.com>
References: <1090604517.13415.0.camel@lucy>
	 <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
	 <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost>
	 <20040724175442.GA26222@plexity.net> <1090692790.12088.16.camel@localhost>
	 <20040726200802.GA9144@nospam.com>
Content-Type: text/plain
Date: Mon, 26 Jul 2004 16:10:31 -0400
Message-Id: <1090872631.28354.3.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 22:08 +0200, Rutger Nijlunsing wrote:

> So the events are some kind of structured printk()s, right? So why not
> printk() as a side-effect of sending an event. Then we could change
> relevant printk()s (but not the debug ones for example) and thereby
> remove the existing printk() and (re)structure them in the process.

I am not so sure I like this.  I want less printk's, not more.

Maybe we can add a send_event_and_printk() if the demand is high.  That
is fine, but I do not want the default events to cause printks.  Printks
are usually human readable sentences, change often, terribly unstable,
etc.  The events should be more basic and stable.


> And if this (together with a file-changed notifier) could help me stop
> polling 28 files once a second for events (/var/log recursively,
> /proc/modules, /proc/mounts, /proc/net/arp and 'netstat -ltup' output)
> I would be really happy...

That is the idea ;-)

	Robert Love


