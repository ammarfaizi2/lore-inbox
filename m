Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTDYLkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTDYLkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:40:23 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:42689 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263880AbTDYLkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:40:22 -0400
Subject: Re: [RFC/PATCH] IDE Power Management try 1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Alexander Atanasov <alex@ssi.bg>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030425114932.GL1012@suse.de>
References: <1051189194.13267.23.camel@gaston> <3EA90176.2080304@ssi.bg>
	 <1051270378.15078.22.camel@gaston>  <20030425114932.GL1012@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051271538.15078.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 13:52:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you add REQ_DRIVE_INTERNAL, and kill the other ones I mentioned, fine
> with me then.
> 
> 	rq->flags & REQ_DRIVE_INTERNAL
> 		rq->cmd[0] == PM
> 			pm stuf
> 		rq->cmd[0] = taskfile
> 			taskfile
> 
> etc. Make sense?

As I just wrote, I'd rather go the whole way then and break up flags
(which is a very bad name btw) into req_type & req_subtype, though
that would mean a bit of driver fixing....

Ben.

