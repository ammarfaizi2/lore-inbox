Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbUCRTF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUCRTF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:05:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43692 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262885AbUCRTF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:05:58 -0500
Date: Thu, 18 Mar 2004 20:05:56 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: floppy driver 2.6.3 question
Message-ID: <20040318190555.GU22234@suse.de>
References: <20040318161647.GT22234@suse.de> <200403181811.i2IIB1f18197@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403181811.i2IIB1f18197@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Peter T. Breuer wrote:
> > You may use REQ_SPECIAL bit as you see fit, and ->special as well. You
> > don't have to use them together, must do though. However, as I said
> > earlier, if you push these requests on to someone else request queue,
> > you must not fiddle with REQ_SPECIAL and/or ->special. In that case you
> > cannot touch/use more than what the block layer already does.
> 
> Well hooray. All seems to be working fine now that I shifted the burden
> to ->special and stopped playing with ->flags (touch wood). Even
> revalidation is working AOK as far as I can tell. I'll reenable that
> read of the first block a-la-floppy to see if it causes some extra magic.
> 
> Many thanks!

No problem, I'm happy it worked out for you.

-- 
Jens Axboe

