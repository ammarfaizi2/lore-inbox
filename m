Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272274AbTG3VTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272275AbTG3VTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:19:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33219
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272274AbTG3VT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:19:29 -0400
Date: Wed, 30 Jul 2003 23:19:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linas@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730211932.GY23835@dualathlon.random>
References: <20030730111639.GI23835@dualathlon.random> <Pine.LNX.4.44.0307301342260.17411-100000@localhost.localdomain> <20030730123458.GM23835@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730123458.GM23835@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 02:34:58PM +0200, Andrea Arcangeli wrote:
> x86.  I never reproduced this myself. I will ask more info on bugzilla,

I've the confirmation it was reproduced on x86, so the timer should have
been running in the same cpu where it was queued (i.e. the base should
have been the same for both del_timer_sync and add_timer). So at the
moment it's not clear what race that patch fixed, but nevertheless I
feel much safer to keep this obviously safe additional locking applied
until we know for sure ;) And I've the confirmation that it makes the
2.4 kernel stable again.

FYI, if I don't answer to further emails on this in the next days, it's
because I'll be on vacations the next 14 days.

Andrea
