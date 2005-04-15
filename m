Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVDOKOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDOKOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 06:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVDOKOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 06:14:53 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:37054 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261798AbVDOKOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 06:14:40 -0400
Date: Fri, 15 Apr 2005 12:12:38 +0200
From: bert hubert <ahu@ds9a.nl>
To: Eduard de Boer <elr.de.boer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MD / RAID5: Memory leak?
Message-ID: <20050415101238.GA15358@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Eduard de Boer <elr.de.boer@gmail.com>, linux-kernel@vger.kernel.org
References: <30e555b5050415010015ddbcf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e555b5050415010015ddbcf4@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 10:00:39AM +0200, Eduard de Boer wrote:
> I use rsync to copy a bunch of files (several GB's) to the designated
> filesystems. But after a while, all file systems get corrupted and
> 'dmesg' lists all kinds of memory corruptions in 'dm' and so on.
> Hence, the file copying stops.

That doesn't sound like a memory leak per se. Can you watch the contents of
/proc/slabinfo ? Or perhaps compare before/after a copy and check if one of
the entries has grown huge.

Also, if you are able, can you let the machine run memtest86 for a night?

Do you see activity of the OOM-killer?

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
