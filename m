Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUDHSHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUDHSHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:07:44 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:52429 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262112AbUDHSHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:07:43 -0400
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
In-Reply-To: <20040408175158.GK31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain>
	<1081435237.1885.144.camel@mulgrave>
	<20040408151415.GB31667@dualathlon.random>
	<1081438124.2105.207.camel@mulgrave>
	<20040408153412.GD31667@dualathlon.random>
	<1081439244.2165.236.camel@mulgrave>
	<20040408161610.GF31667@dualathlon.random>
	<1081441791.2105.295.camel@mulgrave>
	<20040408171017.GJ31667@dualathlon.random>
	<1081446226.2105.402.camel@mulgrave> 
	<20040408175158.GK31667@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2004 13:07:31 -0500
Message-Id: <1081447654.1885.430.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 12:51, Andrea Arcangeli wrote:
> that path can take as long as timeslice to run, not taking interrupts
> for a whole scheduler timeslice is pretty bad.

OK, now I'm confused.  Where's the whole timeslice bit coming from? the
parisc flush_dcache_code better not take a timeslice to execute
otherwise we're in very serious performance trouble.

Does it take as long as a timeslice to do mmap[_shared] list insertion?

James


