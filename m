Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTKBTYb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 14:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTKBTYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 14:24:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:48830 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261784AbTKBTYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 14:24:05 -0500
X-Authenticated: #20450766
Date: Sun, 2 Nov 2003 20:22:23 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-scsi@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <garloff@suse.de>, <gl@dsa-ac.de>
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
In-Reply-To: <20031031114616.A16435@infradead.org>
Message-ID: <Pine.LNX.4.44.0311021933100.4615-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Any reason you fix this driver?  The tmcsim one for the same hardware
> > > looks like much better structured (though a bit obsufacted :))?

Ok, started looking at the tmscsim. A couple of questions:

1) After the "next" element has disappeared from the struct scsi_cmnd,
what is the "correct" / preferred way to queue scsi commands in drivers?
I saw aic7xxx (new) casting a part of struct scsi_pointer SCp in
scsi_cmnd, starting from Status to a list_head (or an anology thereof),
which doesn't seem very nice. Anyway, I didn't find any "standard" way for
doing this. Should host_scribble be used?

2) Actually, which scsi driver (or, better, several drivers) can be
considered well-written and can be taken as examples? I tried looking at
aic7xxx, as it is a pretty new one, but I am not sure if it is really a
good example to follow and it is pretty big too.

Thanks
Guennadi

P.S. Should this thread be taken to linux-scsi or is it better to continue
it on lkml?
---
Guennadi Liakhovetski


