Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVBVRQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVBVRQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 12:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVBVRQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 12:16:54 -0500
Received: from palrel13.hp.com ([156.153.255.238]:25478 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261155AbVBVRQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 12:16:51 -0500
Date: Tue, 22 Feb 2005 11:16:56 -0600
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: CSMI questions
Message-ID: <20050222171656.GA5953@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
I hate to dredge this up again, but, when Eric Moore submitted changes for MPT
Fusion driver containing the CSMI ioctls it was rejected. There was talk on
the linux-scsi list about it being a horrible interface, among other things.
There were also comments about there being a Linux only approach. Personally,
I like that idea but it's not good from a business perspective. Especially
because HP, Dell, and others support more than one OS. Having a unique set of
management apps for each OS would be very cumbersome.

We've also been looking at how to use sysfs rather than ioctls.
 
Some look reasonable, others seem to be restricted by sysfs itself. 
1. only ASCII files are allowed
2. if multiple attributes are contained in one file, who parses out the data?
3. one buffer of size (PAGE_SIZE) may not hold all of the data required

Maybe I'm missing something. If any sysfs experts would like to help me
understand, I'm all ears.

The spec is available at: http://www.t10.org/ftp/t10/document.04/04-345r1.pdf

I'd also like an (brief) explanation of why ioctls are so bad. I've seen the 
reasons of them never going away, etc. But from the beginning of time (UNIX)
ioctls have been the preferred method of user space/kernel communication.
