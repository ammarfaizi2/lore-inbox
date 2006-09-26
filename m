Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWIZMNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWIZMNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIZMNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:13:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32679 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751192AbWIZMNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:13:23 -0400
Date: Tue, 26 Sep 2006 14:13:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap on Fuse deadlocks?
Message-ID: <20060926121319.GA2367@elf.ucw.cz>
References: <45184D88.1010203@comcast.net> <MDEHLPKNGKAHNMBLJOLKMEIEOKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEIEOKAB.davids@webmaster.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-09-25 17:08:13, David Schwartz wrote:
> 
> > Swap on disk I don't get.  A little slow perhaps due to the LZO or zlib
> > compression in the middle (lzolayer lets you pick either); but a total
> > freeze?  What's wrong here, is lzo_fs data getting swapped out and then
> > not swapped in because it's needed to decompress itself?
> 
> The filesystem would have to make sure to lock in memory itself and any code it might need. Obviously, if the filesystem code itself gets swapped out, you cannot swap it back in again ever. Any user-space filesystem that expects to handle swap had better call 'mlock'.
> 

mlock is certainly neccessary, but I am not sure it is enough. Linux
VM was not designed with "swap over userspace" in mind.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
