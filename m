Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319048AbSHFKjT>; Tue, 6 Aug 2002 06:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSHFKjT>; Tue, 6 Aug 2002 06:39:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18632 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319048AbSHFKjS>;
	Tue, 6 Aug 2002 06:39:18 -0400
Date: Tue, 6 Aug 2002 12:42:38 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
Message-ID: <20020806104238.GB1132@suse.de>
References: <13A77E76028@vcnet.vc.cvut.cz> <3D4FA2F8.2050305@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4FA2F8.2050305@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06 2002, Marcin Dalecki wrote:
> device not per channel! If q->request_fn would properly return the
> error count instead of void, we could even get rid ot the
> checking for rq->errors after finishment... But well that's
> entierly different story.

That's nonsense! What exactly would you return from a request_fn after
having queued, eg, 20 commands? Error count is per request, anything
else would be stupid.

-- 
Jens Axboe

