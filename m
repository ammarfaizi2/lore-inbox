Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUESKuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUESKuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUESKuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:50:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:51636 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263544AbUESKuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:50:03 -0400
Date: Wed, 19 May 2004 12:50:01 +0200
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Remove bogus WARN_ON in futex_wait
Message-Id: <20040519125001.3866f830.ak@suse.de>
In-Reply-To: <20040519104339.GG31630@mulix.org>
References: <20040519122350.2792e050.ak@suse.de>
	<20040519104339.GG31630@mulix.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004 13:43:40 +0300
Muli Ben-Yehuda <mulix@mulix.org> wrote:

> On Wed, May 19, 2004 at 12:23:50PM +0200, Andi Kleen wrote:
> > 
> > futex_wait goes to an interruptible sleep, but does a WARN_ON later
> > if it wakes up early. But waking up early is totally legal, since
> > the sleep is interruptible and any signal can wake it up.
> 
> That's not what the WARN_ON is saynig, unless I'm missing
> something. It's checking if we were woken up early and there's no
> signal pending for us. 

True. Anyways, it seems to happen in practice.

-Andi
