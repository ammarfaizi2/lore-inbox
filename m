Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbUAERMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUAERLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:11:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38067 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265191AbUAERKc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:10:32 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 5 Jan 2004 18:13:30 +0100
User-Agent: KMail/1.5.4
Cc: Christophe Saout <christophe@saout.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401051747.45039.bzolnier@elka.pw.edu.pl> <20040105164902.GA3483@suse.de>
In-Reply-To: <20040105164902.GA3483@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051813.30625.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of January 2004 17:49, Jens Axboe wrote:
> On Mon, Jan 05 2004, Bartlomiej Zolnierkiewicz wrote:
> > > calling end_request with a null sector count, ide_end_request will then
> > > take hard_nr_sectors which will end the whole request even if only one
> > > bio was finished, huh? Am I missing something here?
> >
> > No, it is used mainly to fail requests.
> >
> > This hack should be later removed with care
> > (there is some strange comment about locking).
>
> IIRC, it's due to it not always being safe to inspect rq state outside
> of ide_lock. So that makes 0 a magic value that just means 'end the
> first chunk' for ide_end_request().

Why/when it is not safe to do?

