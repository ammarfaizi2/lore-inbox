Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271161AbTHRAWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271182AbTHRAWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:22:36 -0400
Received: from holomorphy.com ([66.224.33.161]:17380 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271161AbTHRAWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:22:35 -0400
Date: Sun, 17 Aug 2003 17:23:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Mike Galbraith <efault@gmx.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030818002325.GQ32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jamie Lokier <jamie@shareable.org>,
	Con Kolivas <kernel@kolivas.org>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Mike Galbraith <efault@gmx.de>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	gaxt <gaxt@rogers.com>, Nick Piggin <piggin@cyberone.com.au>
References: <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <20030816005408.GA21356@mail.jlokier.co.uk> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030816225427.Z639@nightmaster.csn.tu-chemnitz.de> <20030816213901.GA25483@mail.jlokier.co.uk> <20030817144203.J670@nightmaster.csn.tu-chemnitz.de> <20030817200253.GA3543@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817200253.GA3543@mail.jlokier.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 09:02:53PM +0100, Jamie Lokier wrote:
> Vectorizing doesn't help.  In the example of 5 stat() calls, those
> calls could easily be due to 5 different service state machines, each
> responding to a different user request.  There's no easy way to work
> out that they could have been submitted as a single vector.

Well, it's pretty much orthogonal to "making everything async", but it
does have the advantage of batching and hence reducing the number of
system call traps that need to be made to get a given amount of work
done. It's unfortunate there aren't more users of the vectored API's.


-- wli
