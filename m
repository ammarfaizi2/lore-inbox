Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVFLOsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVFLOsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 10:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVFLOsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 10:48:09 -0400
Received: from [62.206.217.67] ([62.206.217.67]:64452 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261886AbVFLOsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 10:48:07 -0400
Message-ID: <42AC4B12.2080508@trash.net>
Date: Sun, 12 Jun 2005 16:47:46 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Juergen Kreileder <jk@blackdown.de>
CC: Andrew Morton <akpm@osdl.org>, Stephen Frost <sfrost@snowman.net>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipt_recent fixes
References: <87ll6o1pbi.fsf@blackdown.de>
In-Reply-To: <87ll6o1pbi.fsf@blackdown.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Kreileder wrote:
> I've had some ipt_recent rules acting strangely after an uptime of
> about 25 days.  The broken behavior is reproducible in the 5 minutes
> before the first jiffies roll-over right after booting too.
> 
> The cause of the problem is the jiffies comparision which doesn't work
> like intended if one of the last hits was more than LONG_MAX seconds
> ago or if the table of last hits contains empty slots and jiffies
> is > LONG_MAX.
> 
> This patch fixes the problem by using get_seconds() instead of
> jiffies.  It also fixes some 64-bit issues.

Thanks, I've added it to my 2.6.13 tree.
