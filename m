Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUDBB21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUDBB21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:28:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:47238 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263480AbUDBB2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:28:22 -0500
Date: Thu, 1 Apr 2004 17:30:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040401173034.16e79fee.akpm@osdl.org>
In-Reply-To: <20040401170705.Y22989@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random>
	<20040401170705.Y22989@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrea Arcangeli (andrea@suse.de) wrote:
> > Oracle needs this sysctl, I designed it and Ken Chen implemented it. I
> > guess google also won't dislike it.
> > 
> > This is a lot simpler than the mlock rlimit and this is people really
> > need (not the rlimit). The rlimit thing can still be applied on top of
> > this. This should be more efficient too (besides its simplicity).
> > 
> > can you apply to mainline?
> 
> This patch seems like the wrong hack to work around missing mlock rlimit
> functionality.  Wouldn't it be better to fix the core problem, and leave
> this patch out of mainline?  I agree with Rik, such a fix (mlock/rlimit)
> will make all the gpg users feel warm and fuzzy ;-)

Rumour has it that the more exhasperated among us are brewing up a patch to
login.c which will allow capabilities to be retained after the setuid.  So
you do

	echo "oracle CAP_IPC_LOCK" > /etc/logincap.conf

And that's it.

See any reason why this won't work?
