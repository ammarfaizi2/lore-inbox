Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbSI0Vdz>; Fri, 27 Sep 2002 17:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbSI0Vdz>; Fri, 27 Sep 2002 17:33:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35280 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261440AbSI0Vdy>;
	Fri, 27 Sep 2002 17:33:54 -0400
Date: Fri, 27 Sep 2002 14:38:41 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file  transfers
Message-ID: <20020927143841.A17108@eng2.beaverton.ibm.com>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
	"Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
	Mathieu Chouquet-Stringer <mathieu@newview.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200209271721.g8RHLTn05231@localhost.localdomain> <2628736224.1033160295@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2628736224.1033160295@aslan.btc.adaptec.com>; from gibbs@scsiguy.com on Fri, Sep 27, 2002 at 02:58:15PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 02:58:15PM -0600, Justin T. Gibbs wrote:
> >> Hooks for sending ordered tags have been in the aic7xxx driver, at
> >> least in FreeBSD's version, since '97.  As soon as the Linux cmd
> >> blocks have such information it will be trivial to have the aic7xxx
> >> driver issue the appropriate tag types.
> > 
> > They already do in 2.5, see scsi_populate_tag_msg() in scsi.h.  This
> > assumes  you're using the generic tag queueing, which the aic7xxx
> > doesn't, but you  could easily key the tag type off REQ_BARRIER.
> 
> If anyone wants to play with the updated aic7xxx and aic79xx drivers
> (new port to 2.5, plus it honors the otag stuff), you can pick it up
> from here:
> 
> 
> http://people.FreeBSD.org/~gibbs/linux/linux-2.5-aic79xxx.tar.gz
> 
> --
> Justin

Any 2.5 patch for the above? Or aic7xxx/Config.in and
aic7xxx/Makefile for 2.5?

Thanks.

-- Patrick Mansfield
