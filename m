Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUHXKWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUHXKWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUHXKWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:22:24 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:56502 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S266566AbUHXKWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:22:22 -0400
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, der.eremit@email.de,
       christer@weinigel.se, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	<412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
	<m37jrr40zi.fsf@zoo.weinigel.se> <4128CAA2.nail9RG21R1OG@burner>
	<Pine.LNX.4.58.0408232113030.4258@kai.makisara.local>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 24 Aug 2004 12:22:21 +0200
In-Reply-To: <Pine.LNX.4.58.0408232113030.4258@kai.makisara.local>
Message-ID: <m3llg4bztu.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara <Kai.Makisara@kolumbus.fi> writes:

> On Sun, 22 Aug 2004, Joerg Schilling wrote:
> 
> > Christer Weinigel <christer@weinigel.se> wrote:
> > BTW: 'mt' should not need to send SCSI comands. THis shoul dbe handled via
> > specilized ioctls.
> > 
> There are already ioctls for changing the tape parameters. Christer, there 
> is no need to introduce tapes into this discussion.

It was en example of another application that needs to modify the mode
pages, and it's interesting to look at how we have solved similar
problems before.

So if we want to be consistent we ought to introduce specialized
ioctls for everything cdrecord wants to do.  Otoh, tape drives don't
seem to be such a fast moving target as CD and DVD burners.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
