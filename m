Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUBPRE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUBPRE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:04:27 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:12758 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265856AbUBPREX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:04:23 -0500
Date: Mon, 16 Feb 2004 11:52:11 -0500
From: Ben Collins <bcollins@debian.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [PATCH] Disable useless bootmem warning
Message-ID: <20040216165211.GC2389@phunnypharm.org>
References: <20040216180028.06402e70.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216180028.06402e70.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've never seen a bug uncovered by this warning too. I considered to disable it 
> by passing a special array of "ok to reserve twice" regions, but on second thought 
> it is just best to remove it completely. Reserving things twice is not usually
> an error.

I have. When I was working to get sparc64 booting from alternate memory
(other than 0x0 physical), those messages helped me a lot.

Maybe make it ifdef'd by CONFIG_DEBUG_BOOTMEM (which is an option that I
know sparc and sparc64 already have).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
