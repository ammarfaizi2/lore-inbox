Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264381AbTEHCHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 22:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbTEHCHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 22:07:55 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3714 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264381AbTEHCHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 22:07:54 -0400
Date: Wed, 07 May 2003 17:06:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: garbled oopsen
Message-ID: <22620000.1052352369@[10.10.2.4]>
In-Reply-To: <20030507184054.684e2bd0.akpm@digeo.com>
References: <20030507180530.23d0e780.rddunlap@osdl.org> <20030507184054.684e2bd0.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can these be cleaned up in any reasonable way?
> 
> It needs some additional spinlock in there.  People have moaned for over a
> year, patches have been floating about but nobody has taken the time to
> finish one off and submit it.

I tried it a while back, the obvious lock approach didn't seem to work, but
I can't seem to find the patch right now. IIRC, printk should be atomic,
so converting it to printk into a line buffer, and then printk'ing the buffer 
(prefaced by cpu number) *should* work. Maybe. I think.

M.

