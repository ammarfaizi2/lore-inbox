Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbTDBQs4>; Wed, 2 Apr 2003 11:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263059AbTDBQs4>; Wed, 2 Apr 2003 11:48:56 -0500
Received: from asie314yy33z9.bc.hsia.telus.net ([216.232.196.3]:5251 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id <S263058AbTDBQsz>; Wed, 2 Apr 2003 11:48:55 -0500
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stateless dropping of packets
References: <87he9ilz05.fsf@deneb.enyo.de>
	<87d6k5ltmo.fsf@saurus.asaurus.invalid> <87wuidndre.fsf@deneb.enyo.de>
From: Kevin Buhr <buhr@telus.net>
In-Reply-To: <87wuidndre.fsf@deneb.enyo.de>
Date: 02 Apr 2003 09:00:18 -0800
Message-ID: <87wuickf6l.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:
> 
> Is this extremely important application of the PREROUTING chain
> documented somewhere?  Should I feel embarrassed? 8-)

No, I haven't seen it documented explicitly.  It's just a fortunate
side effect of the fact that the DROP target can be used anywhere and
there's a fairly general-purpose table ("mangle") that has a
PREROUTING chain.

There's no particular reason for the "filter" table *not* to implement
PREROUTING and POSTROUTING chains (at least not that I can see) except
for a very small performance hit.  I guess no one thought there'd be
much of a use for them.  And it would break the nice rule of thumb
that a packet only passes through one of the three chains of the
"filter" table (not counting packets throught the loopback interface
which pass through OUTPUT then back through INPUT).

-- 
Kevin <buhr@telus.net>
