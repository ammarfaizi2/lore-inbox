Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbTCWD23>; Sat, 22 Mar 2003 22:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbTCWD23>; Sat, 22 Mar 2003 22:28:29 -0500
Received: from rth.ninka.net ([216.101.162.244]:43929 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262243AbTCWD22>;
	Sat, 22 Mar 2003 22:28:28 -0500
Subject: Re: smp overhead, and rwlocks considered harmful
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030322175816.225a1f23.akpm@digeo.com>
References: <20030322175816.225a1f23.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048390771.20776.5.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 22 Mar 2003 19:39:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 17:58, Andrew Morton wrote:
> I've always been a bit skeptical about rwlocks - if you're holding the lock
> for long enough for a significant amount of reader concurrency, you're
> holding it for too long.  eg:  tasklist_lock.

I totally agree with you Andrew, on modern SMP systems rwlocks
are basically worthless.  I think we should kill them off and
convert all instances to spinlocks or some better primitive (perhaps
a more generalized big reader lock, Roman Zippel had something...)

-- 
David S. Miller <davem@redhat.com>
