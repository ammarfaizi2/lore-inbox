Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWCaTL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWCaTL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWCaTL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:11:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751424AbWCaTL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:11:58 -0500
Date: Fri, 31 Mar 2006 11:11:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: tridge@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice support #2
In-Reply-To: <20060331095711.GK14022@suse.de>
Message-ID: <Pine.LNX.4.64.0603311110540.27203@g5.osdl.org>
References: <17452.50912.404106.256236@samba.org> <20060331095711.GK14022@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Mar 2006, Jens Axboe wrote:
> > 
> >   ssize_t psplice(int fdin, int fdout, size_t len, off_t ofs, unsigned flags);
> 
> I definitely see some valid reasons for adding a file offset instead of
> using ->f_pos, I'll leave that decision up to Linus though. Linus?

I think a file offset is fine, the one thing holding me back was just the 
interface. One file offset per fd? Or just have the rule that the file 
offset is for the "non-pipe" device?

		Linus
