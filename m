Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270515AbTHCB1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 21:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270517AbTHCB1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 21:27:04 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:39439 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270515AbTHCB1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 21:27:02 -0400
Date: Sun, 3 Aug 2003 03:26:59 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Message-ID: <20030803012659.GA3933@win.tue.nl>
References: <20030802124536.GB3689@win.tue.nl> <Pine.SOL.4.30.0308021506550.7779-100000@mion.elka.pw.edu.pl> <20030802174229.GA3741@win.tue.nl> <1059858379.20305.23.camel@dhcp22.swansea.linux.org.uk> <20030802233438.GA7652@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802233438.GA7652@codepoet.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 05:34:38PM -0600, Erik Andersen wrote:

> I have rewritten the init_idedisk_capacity() function and taught
> it to behave itself.  It is now much cleaner IMHO

Yes, nice cleanup.

Some comments for later - the patch can be applied as it is:

The assignment
	drive->select.b.lba = 0/1;
is done in the first half of init_idedisk_capacity().
I don't think the presence or disabling of HPA has any effect
on b.lba, so there should not be such assignments in the
second, HPA, half.

My standard muttering: id->... should not be modified.

In my source I test drive->head * drive->sect for being nonzero
before dividing.

Andries


