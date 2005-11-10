Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVKJRNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVKJRNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVKJRNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:13:32 -0500
Received: from terminus.zytor.com ([192.83.249.54]:4565 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750948AbVKJRNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:13:31 -0500
Message-ID: <43737F9E.60703@zytor.com>
Date: Thu, 10 Nov 2005 09:13:02 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9g
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43730E39.6030601@pobox.com>
In-Reply-To: <43730E39.6030601@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
>> Oh, and we will not be moving things out of /usr/bin/ during 1.0
>> timeframe.
> 
> 
> :(  bummer.  I do like the elegance of having /usr/bin/git executing 
> stuff out of /usr/libexec/git.
> 
> /usr/libexec/git also makes it IMO cleaner when integrating git plugins 
> from third parties (rpm -Uvh git-newfeature), because you don't have to 
> worry about the /usr/bin namespace.
> 

It's nice in concept, but I think there are a lot of reasons why this is 
a bad idea:

- "man" doesn't handle it.  It would be another thing if "man" could be 
taught to understand commands like "man cvs checkout" or "man git fetch".

- There is no general way to teach shells etc about it, for tab 
completion etc.

- Makes it harder (but not impossible) to run git from a build directory 
without installing it first.

In comparison, the issue of clutter in /usr/bin is actually a pretty 
small issue, especially with htree.  Most vendors have gone back to 
putting everything into /usr/bin since all variants that involve 
splitting it up seem to be more of a loss than a gain.

	-hpa
