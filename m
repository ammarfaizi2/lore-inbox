Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVJ3T6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVJ3T6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVJ3T6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:58:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34972 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932254AbVJ3T6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:58:05 -0500
Date: Sun, 30 Oct 2005 20:52:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Message-ID: <20051030195254.GA1729@openzaurus.ucw.cz>
References: <200510301637.48842.rjw@sisk.pl> <200510301644.44874.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510301644.44874.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch moves the snapshot-handling functions remaining in swsusp.c
> to snapshot.c (ie. it moves the code without changing the functionality).
>

I'm sorry, but I acked this one too quickly. I'd prefer to keep "relocate" code where
it is, and define "must not collide" as a part of interface. That will keep snapshot.c
smaller/simpler, and I plan to
eventually put responsibility for relocation to userspace.

That should simplify error handling at least: data structures
needed for relocation can be kept in userspace memory, and therefore
we do not risk memory leak in case something goes wrong.


				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

