Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWBRR6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWBRR6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWBRR6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:58:11 -0500
Received: from secure.htb.at ([195.69.104.11]:50954 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932087AbWBRR6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:58:10 -0500
Date: Sat, 18 Feb 2006 18:57:59 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [swsusp] not enough memory
Message-Id: <20060218185759.248208f9.delist@gmx.net>
In-Reply-To: <20060218151115.GC5658@openzaurus.ucw.cz>
References: <20060218005814.6548092d.delist@gmx.net>
	<20060218151115.GC5658@openzaurus.ucw.cz>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FAWLK-0003Ud-00*jx9z96RFeRc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Pavel Machek <pavel@suse.cz> (Sat, 18 Feb 2006 16:11:16
+0100):
> On Sat 18-02-06 00:58:14, Richard Mittendorfer wrote:
> > If I end all apps but the XServer it works. I've allready added some
> > more swapspace, but that didn't help. So, how much memory will I
> > need for a successful suspend or better (since i can't stuff any
> > more into  it) is there a way to minimize the amount needed?
> 
> 128MB should be enough for you. 

Swap? 128M was my first attempt -- OOM when the box was heavily loaded.
IIRC no effect on swsusp - there are 64M Ram + 2M Video + Kernel + X?. 
The reason I did it were some google results talking about free pages.
There were some solutions talking about adding swap.
 
(Ram? Would be the way to go, but it's fully loaded.)

> Or try modifying try_to_free memory
> routine to retry shrink_all_mem few more times, with schedule()  in
> between...

Uhh. I don't think this will be a good idea /me ha[ck|rm]ing good ol'
linux source. ;-)

sl ritch
