Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVKOC6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVKOC6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVKOC6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:58:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932300AbVKOC6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:58:19 -0500
Date: Mon, 14 Nov 2005 18:57:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: 2.6.14 X spinning in the kernel
Message-Id: <20051114185751.795b8a3d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0511150247160.24064@skynet>
References: <1132012281.24066.36.camel@localhost.localdomain>
	<20051114161704.5b918e67.akpm@osdl.org>
	<1132015952.24066.45.camel@localhost.localdomain>
	<20051114173037.286db0d4.akpm@osdl.org>
	<Pine.LNX.4.58.0511150247160.24064@skynet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@linux.ie> wrote:
>
> 
> >
> > ah-hah.  We've had machines stuck in radeon_do_wait_for_idle() before.  In
> > fact, my workstation was doing it a year or two back.
> >
> > Are you able to identify the most recent kernel which didn't do this?
> >
> > David, is there a common cause for this?  ISTR that it's a semi-FAQ.
> 
> Yes invariably the GPU has crashed and isn't responding to anything.

But radeon_do_wait_for_idle() and radeon_do_wait_for_fifo() have timeouts. 
Should Badari have waited longer?

> 
> Also what X was doing etc at the time is invalulable info..
> 

And whether a particualr kernel version introduced this behaviour.
