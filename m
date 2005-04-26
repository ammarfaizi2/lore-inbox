Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVDZOH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVDZOH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVDZOH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:07:58 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:19913 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261532AbVDZOHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:07:50 -0400
Message-ID: <426E4B07.1040400@ammasso.com>
Date: Tue, 26 Apr 2005 09:07:03 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: roland@topspin.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com>	<20050411171347.7e05859f.akpm@osdl.org>	<4263DEC5.5080909@ammasso.com>	<20050418164316.GA27697@infradead.org>	<4263E445.8000605@ammasso.com>	<20050423194421.4f0d6612.akpm@osdl.org>	<426BABF4.3050205@ammasso.com>	<52is2bvvz5.fsf@topspin.com>	<20050425135401.65376ce0.akpm@osdl.org>	<521x8yv9vb.fsf@topspin.com>	<20050425151459.1f5fb378.akpm@osdl.org>	<426D6D68.6040504@ammasso.com>	<20050425153256.3850ee0a.akpm@osdl.org>	<52vf6atnn8.fsf@topspin.com>	<20050425171145.2f0fd7f8.akpm@osdl.org>	<52acnmtmh6.fsf@topspin.com>	<20050425173757.1dbab90b.akpm@osdl.org>	<426DA58F.3020508@ammasso.com>	<20050425201629.11d9118f.akpm@osdl.org>	<426DB7B2.7000409@ammasso.com> <20050425213315.27db35db.akpm@osdl.org>
In-Reply-To: <20050425213315.27db35db.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Precisely.  That's why I suggested that we have an alternative vma->vm_flag
> bit which behaves in a similar manner to VM_LOCKED (say, VM_LOCKED_KERNEL),
> only userspace cannot alter it.

How about calling it VM_PINNED?  That way, we can define

Locked - won't be swapped to disk, but can be moved around in memory
Pinned - won't be swapped to disk or moved around in memory

