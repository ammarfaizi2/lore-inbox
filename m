Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbTGTS0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 14:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbTGTS0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 14:26:14 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:30638 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S267687AbTGTSZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 14:25:49 -0400
Date: Sun, 20 Jul 2003 20:40:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Separate ACPI_SLEEP and SOFTWARE_SUSPEND options
Message-ID: <20030720184023.GC269@elf.ucw.cz>
References: <200307201334.h6KDYSqC002010@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307201334.h6KDYSqC002010@81-2-122-30.bradfords.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  	  Right now you may boot without resuming and then later resume but
> >  	  in meantime you cannot use those swap partitions/files which were
> >  	  involved in suspending. Also in this case there is a risk that buffers
> >  	  on disk won't match with saved ones.
> 
> What happens on a machine which is sharing swap space between two
> operating systems?  Do we have a way to mark a swap partition which is
> used for suspend data as unusable?  Maybe we could change the
> partition type from 82 to something else.

swsusp changes swap's signature, so swapon will fail.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
