Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVEGIk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVEGIk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVEGIid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:38:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37791 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262794AbVEGIZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:25:54 -0400
Date: Sat, 7 May 2005 09:25:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Seyfried <seife@suse.de>
Cc: Shawn Starr <shawn.starr@rogers.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.12-rc3][SUSPEND] qla1280 (QLogic 12160 Ultra3) blows up on A7M266-D
Message-ID: <20050507082548.GA18700@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stefan Seyfried <seife@suse.de>,
	Shawn Starr <shawn.starr@rogers.com>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050503181018.37973.qmail@web88008.mail.re2.yahoo.com> <427BE2CA.7030007@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427BE2CA.7030007@suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 11:34:02PM +0200, Stefan Seyfried wrote:
> Known, XFS was broken / breaking wrt suspend. Pavel fixed this with the
> XFS guys IIRC and i think those patches were on lkml also, but am not
> sure. => this should work soon.

Pavel's fix wasn't enough.  The fix that has been verified to work is
in 2.6.12-rc4.

> > 2) If I use EXT3, suspending to disk is fine resuming
> > is fine there is no long delay to load the swap memory
> > back to RAM. But when it finishes resuming I get the
> > same ISP error and the partition table gets corrupt as
> > well.
> 
> > Is it likely this SCSI driver doesn't know how to
> > handle suspend events?
> 
> Yes. Almost all drivers that are not commonly used in notebooks are
> totally ignorant of suspend / resume. Even the brand new SATA driver
> stuff (that is actually in almost every new notebook) had no suspend
> support until some days ago.

qla1280 doesn't handle suspend/resume indeed.
