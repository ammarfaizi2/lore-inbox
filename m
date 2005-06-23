Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVFWBuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVFWBuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFWBuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:50:20 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31153 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261972AbVFWBrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:47:43 -0400
Message-ID: <42BA14B8.2020609@pobox.com>
Date: Wed, 22 Jun 2005 21:47:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com> <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
>>>But, like branches, it means that if you want a tag, you need to know the 
>>>tag you want, and download it the same way you download a branch.
>>
>>Still -- that's interesting data that no script currently tracks.  You 
>>gotta fall back to rsync.
> 
> 
> Something like
> 
> 	git-ssh/http-pull -w tags/<tagname> tags/<tagname> <url>
> 
> _should_ hopefully work now (and the "-a" flag should mean that you also 
> get all the objects needed for the tag).

The problem isn't pulling tags, the problem is that nothing 
automatically downloads the 41-byte tag files themselves.  Pulling 
linux-2.6.git after the 2.6.12 release did not cause refs/tags/v2.6.12 
to be downloaded.

With BK, tags came with each pull.  With git, you have to go "outside 
the system" (rsync) just get the new tags.

	Jeff


