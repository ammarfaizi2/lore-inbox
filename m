Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbSIYSQn>; Wed, 25 Sep 2002 14:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262049AbSIYSQn>; Wed, 25 Sep 2002 14:16:43 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:13095 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S262048AbSIYSQm>;
	Wed, 25 Sep 2002 14:16:42 -0400
Subject: Re: 2.4.19: oops in ide-scsi
From: James Stevenson <james@stev.org>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87adm6kofe.fsf@ceramic.fifi.org>
References: <87n0q8tcs8.fsf@ceramic.fifi.org>
	<1032891985.2035.1.camel@god.stev.org> <87smzzksri.fsf@ceramic.fifi.org>
	<1032903706.2445.4.camel@god.stev.org>  <87adm6kofe.fsf@ceramic.fifi.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Sep 2002 19:18:15 +0100
Message-Id: <1032977895.1676.0.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

then i belive there are other possible problems which may by
just as bad

On Wed, 2002-09-25 at 17:46, Philippe Troin wrote:
> James Stevenson <james@stev.org> writes:
> 
> > On Tue, 2002-09-24 at 22:00, Philippe Troin wrote:
> > > James Stevenson <james@stev.org> writes:
> > > 
> > > > Hi
> > > > 
> > > > i am glad somebody else sees the same crash as me the
> > > > request Q gets set to NULL for some reson then tries to
> > > > increment a stats counter in the null pointer.
> > > > i know what the bug is i just dont know how to fix it :>
> > > 
> > > I'm not sure which Q you're talking about.
> > > Is that rq (in idescsi_pc_intr())?
> > 
> > the crash happens on
> > 
> > if (status & ERR_STAT)
> > 	rq->errors++;
> > 
> > because 
> > struct request *rq = pc->rq;
> > is NULL
> 
> Have you tried changing it to:
> 
>         if (status & ERR_STAT && rq)
>         	rq->errors++;
> 
> The code is going to return anyways, and rq is only used here on this
> path.
> 
> BTW, can you reproduce the oops at will? I can't :-(
> 
> Phil.


