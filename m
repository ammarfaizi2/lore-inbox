Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTDYNqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTDYNqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:46:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60033 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263152AbTDYNqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:46:42 -0400
Date: Fri, 25 Apr 2003 15:58:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alexander Atanasov <alex@ssi.bg>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] IDE Power Management try 1
Message-ID: <20030425135829.GM1012@suse.de>
References: <1051271538.15078.27.camel@gaston> <Pine.SOL.4.30.0304251414430.12558-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0304251414430.12558-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> On 25 Apr 2003, Benjamin Herrenschmidt wrote:
> 
> > > If you add REQ_DRIVE_INTERNAL, and kill the other ones I mentioned, fine
> > > with me then.
> > >
> > > 	rq->flags & REQ_DRIVE_INTERNAL
> > > 		rq->cmd[0] == PM
> > > 			pm stuf
> > > 		rq->cmd[0] = taskfile
> > > 			taskfile
> > >
> > > etc. Make sense?
> >
> > As I just wrote, I'd rather go the whole way then and break up flags
> > (which is a very bad name btw) into req_type & req_subtype, though
> > that would mean a bit of driver fixing....
> >
> > Ben.
> 
> req_type & req_subtype makes sense,
> but it is future since driver work is needed

100% agree. It's way too late to change that now. Besides, there's still
plenty of space in there, especially if the IDE bits are collapsed into
one.

-- 
Jens Axboe

