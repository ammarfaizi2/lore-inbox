Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTAURg3>; Tue, 21 Jan 2003 12:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbTAURg3>; Tue, 21 Jan 2003 12:36:29 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:13780 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267123AbTAURg2>;
	Tue, 21 Jan 2003 12:36:28 -0500
Date: Tue, 21 Jan 2003 17:42:37 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121174237.GB13480@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Joel Becker <Joel.Becker@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Wim Coekaerts <Wim.Coekaerts@oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com> <20030121125039.GA5997@codemonkey.org.uk> <20030121174001.GV20972@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121174001.GV20972@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 09:40:02AM -0800, Joel Becker wrote:

 > >  I'm puzzled. What does this do that softdog.c doesn't ?
 > 
 > 	First, softdog.c requires userspace interaction.  Second, softdog.c
 > relies on jiffies.  If the system goes out to lunch via udelay() or
 > another hardware call that freezes the CPUs for a bit, jiffies does not
 > increment.  The system could be frozen for two minutes (qla2x00 used to
 > do this for 90 seconds) and softdog.c never notices, because jiffies
 > hasn't counted a single second during this time.

Ok, seems to make sense now, thanks.
Wouldn't this belong under drivers/char/watchdog too though ?
It seems very 'watchdog-ish' to me.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
