Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbSJUKmU>; Mon, 21 Oct 2002 06:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSJUKmU>; Mon, 21 Oct 2002 06:42:20 -0400
Received: from poup.poupinou.org ([195.101.94.96]:11551 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S261316AbSJUKmT>; Mon, 21 Oct 2002 06:42:19 -0400
Date: Mon, 21 Oct 2002 12:48:22 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ducrot Bruno <poup@poupinou.org>, deanna_bonds@adaptec.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ducrot@poupinou.org
Subject: Re: [PATCH] [2.4.20-pre10]  dpt_i2o fix
Message-ID: <20021021104822.GB23762@poup.poupinou.org>
References: <20021015134001.GA3842@poup.poupinou.org> <1035193932.27318.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035193932.27318.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 10:52:12AM +0100, Alan Cox wrote:
> On Tue, 2002-10-15 at 14:40, Ducrot Bruno wrote:
> > The first chunk of attached patch alloc wait_data with
> > kmalloc(..., GFP_ATOMIC) instead of GPF_KERNEL
> > in the function adpt_i2o_post_wait() because this function
> > is called in the function adpt_i2o_passthru() (line 1717 or
> > so) but with a spin_lock held.
> 
> Given the nature of the usage I think its probably better to fix it
> properly than to just hack it up to be GFP_ATOMIC. If the caller was to
> pass in the wait_data buffer then the problem could be fixed cleanly
> 

This was needed on some of my production servers after an upgrade to 2.4 series
in order to quickly fix some random crashes, and my customers are not happy.
Of course, a better fix should be wrotten.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
