Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTF3P4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTF3P4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:56:20 -0400
Received: from dm5-224.slc.aros.net ([66.219.220.224]:46467 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265176AbTF3P4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:56:19 -0400
Message-ID: <3F0060FD.2010203@aros.net>
Date: Mon, 30 Jun 2003 10:10:37 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Pavel Machek <pavel@ucw.cz>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
References: <Pine.LNX.4.10.10306261014360.412-100000@clements.sc.steeleye.com>
In-Reply-To: <Pine.LNX.4.10.10306261014360.412-100000@clements.sc.steeleye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:

>. . .
>That's not an unreasonable thing to do...it'd be a much more minor change.
>I guess I'm just having a hard time seeing the benefit of rearranging
>all this code. Unless there's some substantial benefit, it seems wiser
>to keep the changes as minimal as possible...after all, the current code
>does work.
>. . .
>
Sorry for the confusion. I think you're looking at the nbd code more 
from the standpoint of fixing problem areas and integration with the 
changes from 2.5. I've had my eye meanwhile on a more robust 
implemenation and enhanced design. The difference being that what I've 
submitted so far are just the changes I've needed along that path which 
also achieve the former target. But the changes clearly aren't ideal for 
the former perspective - in not being minimalistic changes. Just nobody 
else has completely fixed problematic areas of the driver liking locking 
races so I figure if the code also fixes these problematic areas it's 
worth sharing with this audience. YMMV of course.

