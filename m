Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTFEORT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbTFEORT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:17:19 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:4319 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264692AbTFEORR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:17:17 -0400
Subject: Re: [PATCH] IDE Power Management, try 2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1054823279.765.14.camel@gaston>
References: <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
	 <1054823279.765.14.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054823443.766.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 16:30:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 16:27, Benjamin Herrenschmidt wrote:
> > > I had to add yet another rq->flags bit for that, and I think that sucks
> > 
> > You don't have if you use additional, default pm_state (on == 0).
> > This sucks too, but a bit less.
> 
> Can you elaborate ? I'm not sure I understand what you meant

Forget it, my brain finally got a clue ;) Though I don't like the
solution. Adding pm_step & pm_state to struct request or a ptr to
rq_pm_struct seem the way to go to me, though I'm not sure which
of these 2 solution is the best, struct request is already a can
of worms imho... ;) If we ever need more PM fields in there, then
the pointer may be the best solution, but right know, I can't think
of any reason to add more stuffs

> > I think extending struct request is the way to go,
> > pm_step & pm_state or even pointer to rq_pm_struct.
> 
> Ok. I'll wait for Jens ack and go that way if he agrees.
> 
> Ben.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
