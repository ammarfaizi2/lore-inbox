Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUDHRoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUDHRn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:43:59 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:41420 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262103AbUDHRn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:43:57 -0400
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
In-Reply-To: <20040408171017.GJ31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain>
	<1081435237.1885.144.camel@mulgrave>
	<20040408151415.GB31667@dualathlon.random>
	<1081438124.2105.207.camel@mulgrave>
	<20040408153412.GD31667@dualathlon.random>
	<1081439244.2165.236.camel@mulgrave>
	<20040408161610.GF31667@dualathlon.random>
	<1081441791.2105.295.camel@mulgrave> 
	<20040408171017.GJ31667@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2004 12:43:45 -0500
Message-Id: <1081446226.2105.402.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 12:10, Andrea Arcangeli wrote:
> I said above per-arch abstraction, a per-arch abstraction isn't an irq
> safe spinlock, we cannot add an irq safe spinlock there, it'd be too bad
> for all the common archs that don't need to walk those lists (actually
> trees in my -aa tree) from irq context.

I think we agree on the abstraction thing.  I was more wondering what
you thought was so costly about an irq safe spinlock as opposed to an
ordinary one?  Is there something adding to this cost I don't know
about?  i.e. should we be thinking about something like RCU or phased
tree approach to walking the mapping lists?

James


