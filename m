Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTEOJFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTEOJFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:05:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:49891 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263875AbTEOJFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:05:46 -0400
Date: Thu, 15 May 2003 02:20:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: dmccr@us.ibm.com, mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-Id: <20030515022000.0eb9db29.akpm@digeo.com>
In-Reply-To: <20030515085519.GV1429@dualathlon.random>
References: <154080000.1052858685@baldur.austin.ibm.com>
	<20030513181018.4cbff906.akpm@digeo.com>
	<18240000.1052924530@baldur.austin.ibm.com>
	<20030514103421.197f177a.akpm@digeo.com>
	<82240000.1052934152@baldur.austin.ibm.com>
	<20030515004915.GR1429@dualathlon.random>
	<20030515013245.58bcaf8f.akpm@digeo.com>
	<20030515085519.GV1429@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 09:18:30.0638 (UTC) FILETIME=[F36B50E0:01C31AC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> and it's still racy

damn, and it just booted ;)

I'm just a little bit concerned over the ever-expanding inode.  Do you
think the dual sequence numbers can be replaced by a single generation
counter?

I do think that we should push the revalidate operation over into the vm_ops. 
That'll require an extra arg to ->nopage, but it has a spare one anyway (!).


