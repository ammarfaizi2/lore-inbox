Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbTAUMoa>; Tue, 21 Jan 2003 07:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTAUMoa>; Tue, 21 Jan 2003 07:44:30 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:55761 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267041AbTAUMo3>;
	Tue, 21 Jan 2003 07:44:29 -0500
Date: Tue, 21 Jan 2003 12:50:39 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121125039.GA5997@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Joel Becker <Joel.Becker@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Wim Coekaerts <Wim.Coekaerts@oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121011954.GO20972@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 05:19:54PM -0800, Joel Becker wrote:
 > Folks,
 > 	Attached is a patch adding hangcheck-timer.  It is used to detect
 > when the system goes out to lunch for a period of time, and then
 > returns.  This is interesting for debugging drivers as well as for
 > clustering environments.
 > 	The module sets a timer.  When the timer goes off, it then uses
 > get_cycles() to determine how much real time has passed.
 > 	On a normal system, the real elapsed time will be almost
 > identical to the expected timer duration.  However, if a device decided
 > to udelay for 60 seconds (or some other circumstance), the module takes
 > notice.  If the margin of error passes a threshold, the driver prints a
 > warning or the machine is rebooted.

Hi Joel,
 I'm puzzled. What does this do that softdog.c doesn't ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
