Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbTKDAhb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 19:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTKDAhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 19:37:31 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:25866 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP id S263577AbTKDAha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 19:37:30 -0500
Message-ID: <3FA70015.8080805@ixiacom.com>
Date: Mon, 03 Nov 2003 17:25:41 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: fleury@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: Re: allocating netlink families?
References: <3FA6F628.70305@ixiacom.com> <20031103170935.5c6688b9.davem@redhat.com>
In-Reply-To: <20031103170935.5c6688b9.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Mon, 03 Nov 2003 16:43:20 -0800
> Dan Kegel <dkegel@ixiacom.com> wrote:
> 
> 
>>Has there been any discussion of how one should pick
>>netlink family numbers for new stuff like netkeeper?
>>Sure, everyone could use NETLINK_USERSOCK, but
>>that means only one new netlink module could be resident at a time...
> 
> 
> When it's determined to be useful and to be added to
> the main kernel sources, we'll allocate a number.
> Before that time, there is no need to allocate.  We'd
> run out quickly if everyone with a funny netlink thing they
> wanted to do asked for a number.

I guess I was really wondering what somebody who wants to
use two netlink things in the same system should do.  Steal
family 31, I suppose.  Ah, well.
I'll just happily use NETLINK_USERSOCK, and won't ask about
clashes until I really run into one.

- Dan


