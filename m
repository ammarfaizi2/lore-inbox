Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUBSIg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUBSIg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:36:28 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:38039 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S264433AbUBSIg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:36:27 -0500
Date: Thu, 19 Feb 2004 08:34:17 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Jamie Lokier <jamie@shareable.org>
cc: David Schwartz <davids@webmaster.com>, hasso@estpak.ee,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: raw sockets and blocking
In-Reply-To: <20040219075343.GA4113@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402190831200.25392@fogarty.jakma.org>
References: <MDEHLPKNGKAHNMBLJOLKMENGKHAA.davids@webmaster.com>
 <Pine.LNX.4.58.0402190622010.25392@fogarty.jakma.org>
 <20040219075343.GA4113@mail.shareable.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Jamie Lokier wrote:

> I hate to check the obvious, but did you try setting the O_NONBLOCK
> flag for the socket?  Did you try setting the MSG_DONTWAIT flag for
> the sendmsg operation?

We're select() driven, so the problem is not that the process
literally blocks and sleeps, its that the socket never becomes ready
to write again.

> -- Jamie

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Assembly language experience is [important] for the maturity
and understanding of how computers work that it provides.
		-- D. Gries
