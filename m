Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVBGVT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVBGVT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVBGVT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:19:56 -0500
Received: from agminet03.oracle.com ([141.146.126.230]:42666 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S261317AbVBGVTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:19:54 -0500
Message-ID: <4207DB68.2050406@oracle.com>
Date: Mon, 07 Feb 2005 13:19:36 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] invalidate range of pages after direct IO write
References: <20050129011906.29569.18736.24335@volauvent.pdx.zabbo.net>	<20050203161927.0090655c.akpm@osdl.org>	<4202D55E.5030900@oracle.com>	<20050203182854.0b36fb4d.akpm@osdl.org>	<42040176.1030703@oracle.com> <20050204153530.0409744b.akpm@osdl.org>
In-Reply-To: <20050204153530.0409744b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> But this won't happen if next
>>started as 0 and we didn't update it.  I don't know if retrying is the
>>intended behaviour or if we care that the start == 0 case doesn't do it.
> 
> 
> Good point.  Let's make it explicit?

Looks great.  I briefly had visions of some bitfield to pack the three
boolean ints we have and then quickly came to my senses. :)

I threw together those other two patches that work with ranges around
direct IO.  (unmaping before r/w and writing and waiting before reads).
 rc3-mm1 is angry with my test machine so they're actually against
current -bk with this first invalidation patch applied.  I hope that
doesn't make life harder than it needs to be.  I'll send them under
seperate cover.

- z
