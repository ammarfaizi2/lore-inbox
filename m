Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVHAVMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVHAVMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVHAVKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:10:01 -0400
Received: from tim.rpsys.net ([194.106.48.114]:59833 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261286AbVHAVIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:08:13 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508011335090.7011@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 22:07:53 +0100
Message-Id: <1122930474.7648.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 13:36 -0700, Christoph Lameter wrote:
> Could you get me some more information about the hang? A stacktrace would 
> be useful.

I've attached gdb to it and its stuck in memcpy (from glibc). The rest
of the trace is junk as glibc's arm memcpy implementation will have
destroyed the frame pointer. The current instruction is a store to
memory (stmneia r0!, {r3,r4} ) and the instruction pointer isn't
changing...

> Well the device is able to run X so I guess that a slow kernel compile 
> would work. At least the embedded device that I used to work on was 
> capable of doing that (but then we had Debian on that thing which made 
> doing stuff like that very easy).

I agree, it would probably do a slow compile. I have no compiler or
development tools on it though and only slow vfat disks other than the
internal flash. There are plenty of options to get such things working
but it will take me a while to setup.

Hopefully the memcpy clue will mean something?

Richard

