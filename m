Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbTGTT4T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbTGTT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:56:18 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:20355 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S268130AbTGTT4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:56:17 -0400
Date: Sun, 20 Jul 2003 21:20:53 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307202020.h6KKKrxh003150@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, pavel@ucw.cz
Subject: Re: Separate ACPI_SLEEP and SOFTWARE_SUSPEND options
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  	  Right now you may boot without resuming and then later resume but
> > >  	  in meantime you cannot use those swap partitions/files which were
> > >  	  involved in suspending. Also in this case there is a risk that buffers
> > >  	  on disk won't match with saved ones.
> > 
> > What happens on a machine which is sharing swap space between two
> > operating systems?  Do we have a way to mark a swap partition which is
> > used for suspend data as unusable?  Maybe we could change the
> > partition type from 82 to something else.
>
> swsusp changes swap's signature, so swapon will fail.

Aren't there some OSes that just blindly use the whole partition,
without looking for a swap signature?  I suppose that's really a
problem that needs to be fixed with the other OS, though, to recognise
the swsusp signature and disable swapping during that boot.

John.
