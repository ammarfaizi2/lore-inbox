Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUGZUix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUGZUix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUGZUgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:36:38 -0400
Received: from wingding.demon.nl ([82.161.27.36]:4483 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S265663AbUGZUIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:08:07 -0400
Date: Mon, 26 Jul 2004 22:08:02 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Robert Love <rml@ximian.com>
Cc: dsaxena@plexity.net, Michael Clark <michael@metaparadigm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040726200802.GA9144@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <1090604517.13415.0.camel@lucy> <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost> <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost> <20040724175442.GA26222@plexity.net> <1090692790.12088.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090692790.12088.16.camel@localhost>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> 
> Criteria for adding the event would be that user-space needs to know
> about it, and would normally have to poll to get the information.  If
> the event is so non-important that right now no one even knows about it
> or cares about it, it may not be worth adding.

So the events are some kind of structured printk()s, right? So why not
printk() as a side-effect of sending an event. Then we could change
relevant printk()s (but not the debug ones for example) and thereby
remove the existing printk() and (re)structure them in the process.

And if this (together with a file-changed notifier) could help me stop
polling 28 files once a second for events (/var/log recursively,
/proc/modules, /proc/mounts, /proc/net/arp and 'netstat -ltup' output)
I would be really happy...

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
