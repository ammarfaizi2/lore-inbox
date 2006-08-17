Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWHQPq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWHQPq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWHQPq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:46:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:45772 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965156AbWHQPq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:46:57 -0400
Date: Thu, 17 Aug 2006 08:40:23 -0700
From: Greg KH <greg@kroah.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 7/7] UBC: proc interface
Message-ID: <20060817154023.GA7070@kroah.com>
References: <44E33893.6020700@sw.ru> <44E33D5E.7000205@sw.ru> <20060816171328.GA27898@kroah.com> <44E47274.70506@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E47274.70506@sw.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 05:43:16PM +0400, Kirill Korotaev wrote:
> >On Wed, Aug 16, 2006 at 07:44:30PM +0400, Kirill Korotaev wrote:
> >
> >>Add proc interface (/proc/user_beancounters) allowing to see current
> >>state (usage/limits/fails for each UB). Implemented via seq files.
> >
> >
> >Ugh, why /proc?  This doesn't have anything to do with processes, just
> >users, right?  What's wrong with /sys/kernel/ instead?
> We can move it, if there are much objections.

I am objecting.  /proc is for processes so do not add any new files
there that do not deal with processes.

> >Or /sys/kernel/debug/user_beancounters/ in debugfs as this is just a
> >debugging thing, right?
> debugfs is usually OFF imho.

No, distros enable it.

> you don't export meminfo information in debugfs, correct?

That is because the meminfo is tied to processes, or was added to proc
before debugfs came about.

Then how about just /sys/kernel/ instead and use sysfs?  Just remember,
one value per file please.

thanks,

greg k-h
