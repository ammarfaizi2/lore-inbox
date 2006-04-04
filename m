Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWDDIzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWDDIzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDDIzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:55:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932385AbWDDIzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:55:31 -0400
Date: Tue, 4 Apr 2006 01:54:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel-news@e-dict.net
Cc: Ingo.Freund@e-dict.net, linux-kernel@vger.kernel.org
Subject: Re: out of memory
Message-Id: <20060404015432.255fe0aa.akpm@osdl.org>
In-Reply-To: <44322EC5.5030006@e-dict.net>
References: <4431001C.5080905@e-dict.net>
	<20060403204048.092db2cc.akpm@osdl.org>
	<44322EC5.5030006@e-dict.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Freund <Ingo.Freund@e-dict.net> wrote:
>

Please don't edit Cc:'s when working with kernel developers - just do
reply-to-all.

> Andrew Morton wrote:
> > Ingo Freund <Ingo.Freund@e-dict.net> wrote:
> >> Apr  2 10:56:11 dbm kernel: 8538 pages slab
> > 
> > and it's not in slab.
> > 
> >> Apr  2 10:56:11 dbm kernel: Symbols match kernel version 2.6.13.
> > 
> > Boy, 2.6.13 was a long time ago - I'm sure we fixed many leaks since then,
> > but I do not recall any particular patch which might fix this, sorry.
> > 
> > Your best option would be to seek a kernel upgrade.
> 
> I'll give a try to the last kernel version

OK, 2.6.16.1 would suit.

> Is there a way to get those kernel/memory information from time
> to time from the running system which I found in the syslog file?

/proc/meminfo gives a decent summary.

To watch your ZONE_NORMAL disappearing it would be better to monitor
/proc/zoneinfo.  There you'll see `free', `active', `inactive' and
`present'.  In /proc/meminfo you'll find the slab utilisation.

It should be approximately true that free+active+inactive+slab = present.
