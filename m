Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264536AbTCZFob>; Wed, 26 Mar 2003 00:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264544AbTCZFob>; Wed, 26 Mar 2003 00:44:31 -0500
Received: from waste.org ([209.173.204.2]:24527 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S264536AbTCZFoa>;
	Wed, 26 Mar 2003 00:44:30 -0500
Date: Tue, 25 Mar 2003 23:55:25 -0600
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: ptb@it.uc3m.es, Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
Message-ID: <20030326055525.GA20244@waste.org>
References: <200303252053.h2PKrRn09596@oboe.it.uc3m.es> <3E81132C.9020506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E81132C.9020506@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 09:40:44PM -0500, Jeff Garzik wrote:
> Peter T. Breuer wrote:
> >"Justin Cormack wrote:"
> >>And I am intending to write an iscsi client sometime, but it got
> >>delayed. The server stuff is already available from 3com.
> >
> >
> >Possibly, but ENBD is designed to fail :-). And networks fail.
> >What will your iscsi implementation do when somebody resets the
> >router? All those issues are handled by ENBD. ENBD breaks off and
> >reconnects automatically. It reacts right to removable media.
> 
> Yeah, iSCSI handles all that and more.  It's a behemoth of a 
> specification.  (whether a particular implementation implements all that 
> stuff correctly is another matter...)

Indeed, there are iSCSI implementations that do multipath and
failover.

Both iSCSI and ENBD currently have issues with pending writes during
network outages. The current I/O layer fails to report failed writes
to fsync and friends.

> BTW, I'm a big enbd fan :)  I like enbd for it's _simplicity_ compared 
> to iSCSI.

Definitely. The iSCSI protocol is more powerful but _much_ more
complex than ENBD. I've spent two years working on iSCSI but guess
which I use at home..

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
