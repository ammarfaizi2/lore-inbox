Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVJQIwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVJQIwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVJQIwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:52:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48585 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932207AbVJQIwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:52:17 -0400
Date: Mon, 17 Oct 2005 14:16:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: torvalds@osdl.org, "Serge Belyshev" <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Manfred Spraul" <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017084609.GA6257@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JTFDVq8K.1129537967.5390760.khali@localhost>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 10:32:47AM +0200, Jean Delvare wrote:
> 
> > In fact, in that path you could even do a full "rcu_process_callbacks()".
> > After all, this is not that different from signal handling.
> >
> > Gaah. I had really hoped to release 2.6.14 tomorrow. It's been a week
> > since -rc4.
> 
> Isn't reverting the original change an option? 2.6.13 was working OK if
> I'm not mistaken.

IMO, putting the file accounting in slab ctor/dtors is not very
reliable because it depends on slab not getting fragmented.
Batched freeing in RCU is just an extreme case of it. We needed
to fix file counting anyway.

Thanks
Dipankar
