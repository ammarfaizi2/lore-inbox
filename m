Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTIYJNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 05:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTIYJNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 05:13:44 -0400
Received: from dyn-ctb-210-9-245-204.webone.com.au ([210.9.245.204]:19975 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261773AbTIYJNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 05:13:43 -0400
Message-ID: <3F72B1BC.7080405@cyberone.com.au>
Date: Thu, 25 Sep 2003 19:13:32 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
References: <20030925071252.GE22525@vitelus.com> <20030925004301.171f6645.akpm@osdl.org> <20030925075852.GI22525@vitelus.com> <20030925011052.6f8beab2.akpm@osdl.org> <20030925083142.GK22525@vitelus.com>
In-Reply-To: <20030925083142.GK22525@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Aaron Lehmann wrote:

>On Thu, Sep 25, 2003 at 01:10:52AM -0700, Andrew Morton wrote:
>
>>A few things to run are `top', `ps' and `vmstat 1'.
>>
>
>The first two do not show any information out of the ordinary other
>than the fact that the load average is 11 while only two rsync
>processes are using any CPU at all.
>

But the load average will be 11 because there are processes stuck in the
kernel somewhere in D state. Have a look for them. They might be things
like pdflush, kswapd, scsi_*, etc. Try getting an Alt+SysRq+T dump of
them as well.


