Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbUK3NYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUK3NYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUK3NYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:24:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65427 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262070AbUK3NYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:24:35 -0500
Date: Tue, 30 Nov 2004 14:02:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 49/51: Checksumming
Message-ID: <20041130130227.GA4670@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300589.5805.392.camel@desktop.cunninghams> <200411290455.10318.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411290455.10318.rob@landley.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > A plugin for verifying the consistency of an image. Working with kdb, it
> > can look up the locations of variations. There will always be some
> > variations shown, simply because we're touching memory before we get
> > here and as we check the image.
> 
> A while back I suggested checking the last mount time of the mounted local 
> filesystems as a quick and dirty sanity check between loading the image and 
> unfreezing all the processes.  (Since a read-only mount shouldn't touch this, 
> triggering swsusp resume from userspace after prodding various hardware 
> shouldn't cause a major problem either...)  Does that sound like a good idea?

Yes, it would be good sanity check. ext3 replays journals even on
read-only mount so your / will need to be ext2...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

