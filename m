Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVBFMuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVBFMuI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVBFMuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:50:08 -0500
Received: from ns.suse.de ([195.135.220.2]:37004 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261202AbVBFMuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:50:03 -0500
Date: Sun, 6 Feb 2005 13:50:02 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206125002.GF30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206124523.GA762@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i.e. all mappings are executable (i.e. READ_IMPLIES_EXEC effect) - the
> intended change. (although i dont fully agree with PT_GNU_STACK being
> about something else than the stack, from a security POV if the stack is
> executable then all bets are off anyway. The heap and all mmaps being
> executable too in that case makes little difference.)

Well, that won't fix mono (and i suspect wine) and the others
who don't use trampolines that the compiler can detect.

And breaking programs silently definitely doesn't make them secure!

-Andi
