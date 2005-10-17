Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVJQKzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVJQKzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 06:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVJQKzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 06:55:40 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:65507 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932264AbVJQKzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 06:55:39 -0400
Date: Mon, 17 Oct 2005 19:54:58 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, torvalds@osdl.org,
       shai@scalex86.org, Andi Kleen <ak@suse.de>
In-Reply-To: <200510171153.56063.ak@suse.de>
References: <20051017025007.35ae8d0e.akpm@osdl.org> <200510171153.56063.ak@suse.de>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051017193904.0C96.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. Ravikiran-san.

> > This is an ia64 patch - what point was there in testing it on an x460?
> >
> > Is something missing here?
> 
> x86-64 shares that code with ia64.
> 
> The patch is actually not quite correct - in theory node 0 could be too small 
> to contain the full swiotlb bounce buffers.
> 
> The real fix would be to get rid of the pgdata lists and just walk the 
> node_online_map on bootmem.c. The memory hotplug guys have
> a patch pending for this.

Yeah!
I posted a patch for this problem to linux-mm ML. Could you try it? 
http://marc.theaimsgroup.com/?l=linux-mm&m=112791558527522&w=2

2.6.14-rc4-mm1 already has merged it. ;-)

Thanks.

-- 
Yasunori Goto 

