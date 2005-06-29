Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVF2XO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVF2XO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVF2XLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:11:44 -0400
Received: from mx1.suse.de ([195.135.220.2]:46551 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262729AbVF2XLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:11:08 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: Al Boldi <a1426z@gawab.com>, "'Nathan Scott'" <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: SPAM: Re: XFS corruption during power-blackout
References: <20050629001847.GB850@frodo.suse.lists.linux.kernel>
	<200506290453.HAA14576@raad.intranet.suse.lists.linux.kernel>
	<556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org.suse.lists.linux.kernel>
	<42C2E0BC.8040508@xfs.org.suse.lists.linux.kernel>
	<254889.27725ab660aa106eb6acc07307d71ef1fbd5b6fd366aebef9e2f611750fbcb467e46e8a4.IBX@taniwha.stupidest.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Jun 2005 01:11:03 +0200
In-Reply-To: <254889.27725ab660aa106eb6acc07307d71ef1fbd5b6fd366aebef9e2f611750fbcb467e46e8a4.IBX@taniwha.stupidest.org.suse.lists.linux.kernel>
Message-ID: <p73irzw3gjc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> writes:

> If caching is enabled I still lose data.  Linux does have a concept of
> write barriers but these are presently not implemented for XFS right
> now.

I implemented them some time ago for log writes in XFS. Not for fsync though,
although fsync usually does a log write afterwards so it should work
in practice too. fdatasync might not.

Don't know if the code hasn't bit rotted away and it also was a bit
dumb. It was definitely there at some point.

But then a lot of ATA disks and SCSI don't support barriers. Or at least
the IDE barrier tests fails on several of my machines.

-Andi
