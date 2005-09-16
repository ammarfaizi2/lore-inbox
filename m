Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbVIPBEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbVIPBEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 21:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbVIPBEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 21:04:11 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49626 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161008AbVIPBEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 21:04:10 -0400
Message-ID: <432A19F6.8050605@pobox.com>
Date: Thu, 15 Sep 2005 21:03:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Current state of GIT fetch/pull clients
References: <Pine.LNX.4.63.0509142319330.23242@iabervon.org> <7vbr2tx51n.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7vbr2tx51n.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> Neither http nor rsync transports know about the 'alternates'
> mechanism yet, so if a downloader does:
> 
>     $ git pull http://kernel.org/pub/scm/linux/kernel/git/$u/$tree
>     $ git pull rsync://kernel.org/pub/scm/linux/kernel/git/$u/$tree
> 
> unless the downloader has already fetched from Linus'
> repository, this will not work.
> 
>   * In the case of rsync transport, it would slurp all objects
>     your repository has, but does not get objects from Linus'
>     repository.  Also, rsync will overwrite the
>     objects/info/alternates file the downloader has in his
>     repository with what you have in your repository, which is
>     not what we want.

Yes, this is why I don't bother with alternates at the present time. 
Users of my repos, at least, have been trained to use rsync://... and 
currently expect to get a working tree that way.

	Jeff


