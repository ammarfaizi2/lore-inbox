Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWCaTkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWCaTkK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWCaTkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:40:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41822 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932106AbWCaTkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:40:08 -0500
Date: Fri, 31 Mar 2006 21:40:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: tridge@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331194012.GE14022@suse.de>
References: <17452.50912.404106.256236@samba.org> <20060331095711.GK14022@suse.de> <Pine.LNX.4.64.0603311110540.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603311110540.27203@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2006, Linus Torvalds wrote:
> 
> 
> On Fri, 31 Mar 2006, Jens Axboe wrote:
> > > 
> > >   ssize_t psplice(int fdin, int fdout, size_t len, off_t ofs, unsigned flags);
> > 
> > I definitely see some valid reasons for adding a file offset instead of
> > using ->f_pos, I'll leave that decision up to Linus though. Linus?
> 
> I think a file offset is fine, the one thing holding me back was just the 
> interface. One file offset per fd? Or just have the rule that the file 
> offset is for the "non-pipe" device?

Intuitively, I'd expect the offset to be tied to the non-pipe if I were
to eg see this for the first time. So my vote would go for that.

-- 
Jens Axboe

