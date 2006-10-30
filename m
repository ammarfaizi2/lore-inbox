Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbWJ3Rep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWJ3Rep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161245AbWJ3Rep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:34:45 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:25751 "EHLO
	smtp151.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1161203AbWJ3Reo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:34:44 -0500
Subject: Re: [PATCH] jfs: Add splice support
From: Daniel Drake <ddrake@brontes3d.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <1162227415.24229.2.camel@kleikamp.austin.ibm.com>
References: <20061030163148.2412D7B40A0@zog.reactivated.net>
	 <1162227415.24229.2.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 12:29:19 -0500
Message-Id: <1162229359.7280.20.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 10:56 -0600, Dave Kleikamp wrote:
> On Mon, 2006-10-30 at 16:31 +0000, Daniel Drake wrote:
> > This allows the splice() and tee() syscalls to be used with JFS.
> 
> Gosh, that was easy.  Why couldn't I do that?  :-)
> 
> Answer: I would have had to test it.
> 
> I'm assuming you did?

Yep:

Created a 100mb file from /dev/urandom on an ext3 partition
Used splice-cp to copy it onto a JFS partition
Used splice-cp to copy it from that JFS partition onto another JFS
partition

I checked md5sums at all stages, seems to work fine.

Thanks!
Daniel


