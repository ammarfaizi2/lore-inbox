Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268473AbTCAA7z>; Fri, 28 Feb 2003 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268482AbTCAA7z>; Fri, 28 Feb 2003 19:59:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23192 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268473AbTCAA7y>;
	Fri, 28 Feb 2003 19:59:54 -0500
Date: Fri, 28 Feb 2003 16:52:58 -0800 (PST)
Message-Id: <20030228.165258.114281488.davem@redhat.com>
To: pavel@suse.cz
Cc: bcollins@debian.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030228132330.GC8498@atrey.karlin.mff.cuni.cz>
References: <20030227.123701.16257819.davem@redhat.com>
	<20030227211256.GR21100@phunnypharm.org>
	<20030228132330.GC8498@atrey.karlin.mff.cuni.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Fri, 28 Feb 2003 14:23:31 +0100

   cmd probably could be u32 (since it is ioctl32 after all), but I doubt
   it matters, as two following entries are pointers so it looks to me
   like it is going to be lost by alignment, anyway.
   
These pointers can (and WERE!) 32-bit on sparc64, so we wouldn't
have the alignment problem there.

All kernel text on sparc64 (even in modules) occur in the lower
32-bits of the address apce.
