Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTEYQma (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 12:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTEYQma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 12:42:30 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:54722 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263270AbTEYQm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 12:42:29 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jens Axboe <axboe@suse.de>, "Paulo Andre'" <fscked@iol.pt>
Subject: Re: [PATCH] Check copy_*_user return value in drivers/block/scsi_ioctl.c
Date: Sun, 25 May 2003 18:54:38 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030525172549.7df834f9.fscked@iol.pt> <20030525162844.GJ812@suse.de>
In-Reply-To: <20030525162844.GJ812@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305251854.38636.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 25. Mai 2003 18:28 schrieb Jens Axboe:
> On Sun, May 25 2003, Paulo Andre' wrote:
> > Hi Jens,
> >
> > Please find attached a trivial patch that checks both
> > copy_to_user() and copy_from_user() returns values in scsi_ioctl.c,
> > returning accordinly in case of a transfer error.
>
> See above, we've already done access_ok() on the buffer so the
> "unchecked" copy_to/from_user are done that way on purpose. I suppose it
> could be made more explicit with __copy_to/from_user().

Doesn't this race with munmap on SMP?

	Regards
		Oliver

