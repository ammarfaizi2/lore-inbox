Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268775AbTBZPMt>; Wed, 26 Feb 2003 10:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268776AbTBZPMt>; Wed, 26 Feb 2003 10:12:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24337 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268775AbTBZPMr>; Wed, 26 Feb 2003 10:12:47 -0500
Date: Wed, 26 Feb 2003 07:20:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <20030226072727.GO10411@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0302260713210.1423-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Feb 2003, William Lee Irwin III wrote:
> In message mbligh wrote:
> >> I put an esr_disable flag in there a while back ... does that workaround it?
> 
> On Wed, Feb 26, 2003 at 06:14:42PM +1100, Rusty Russell wrote:
> > Yes.  Hmm.  Wonder if that helps my SMP wierness, too.
> 
> It shouldn't be set on anything but NUMA-Q and "bigsmp".

Hmm.. Why is it right on those, but not on normal machines? The APIC is 
the same, and if the big machines need it, apparently at least _one_ small 
machine needs it too..

Also, if we find that the ESR value was non-zero, it sounds a bit stupid 
to enable error delivery at bootup. We already know there was an error, we 
don't need to be told.

		Linus

