Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbTGEVaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbTGEVaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:30:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:31371 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266501AbTGEVaQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:30:16 -0400
Date: Sat, 5 Jul 2003 22:44:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030705214413.GA28824@mail.jlokier.co.uk>
References: <20030703023714.55d13934.akpm@osdl.org> <200307051728.12891.phillips@arcor.de> <20030705121416.62afd279.akpm@osdl.org> <200307052309.12680.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307052309.12680.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Unfortunately, negative priority requires root privilege, at least
> on Debian.
>
> That's dumb.  By default, the root privilege requirement should kick
> in at something like -5 or -10, so ordinary users can set priorities
> higher than the default, as well as lower.  For the millions of
> desktop users out there, sound ought to work by default, not be
> broken by default.

The security problem, on a multi-user box, is that negative priority
apps can easily take all of the CPU and effectively lock up the box.

Something I've often thought would fix this is to allow normal users
to set negative priority which is limited to using X% of the CPU -
i.e. those tasks would have their priority raised if they spent more
than a small proportion of their time using the CPU.

-- Jamie
