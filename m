Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbTDYMEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTDYMEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:04:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60314 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263892AbTDYMET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:04:19 -0400
Date: Fri, 25 Apr 2003 14:16:05 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jens Axboe <axboe@suse.de>, Alexander Atanasov <alex@ssi.bg>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] IDE Power Management try 1
In-Reply-To: <1051271538.15078.27.camel@gaston>
Message-ID: <Pine.SOL.4.30.0304251414430.12558-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Apr 2003, Benjamin Herrenschmidt wrote:

> > If you add REQ_DRIVE_INTERNAL, and kill the other ones I mentioned, fine
> > with me then.
> >
> > 	rq->flags & REQ_DRIVE_INTERNAL
> > 		rq->cmd[0] == PM
> > 			pm stuf
> > 		rq->cmd[0] = taskfile
> > 			taskfile
> >
> > etc. Make sense?
>
> As I just wrote, I'd rather go the whole way then and break up flags
> (which is a very bad name btw) into req_type & req_subtype, though
> that would mean a bit of driver fixing....
>
> Ben.

req_type & req_subtype makes sense,
but it is future since driver work is needed

--
Bartlomiej

