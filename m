Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbSJUSEJ>; Mon, 21 Oct 2002 14:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJUSEJ>; Mon, 21 Oct 2002 14:04:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27848 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261453AbSJUSEI>; Mon, 21 Oct 2002 14:04:08 -0400
Message-ID: <3DB44252.A9ECB0B5@us.ibm.com>
Date: Mon, 21 Oct 2002 11:07:14 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [PATCH]IPC locks breaking down with RCU
References: <Pine.LNX.4.44.0210201346180.1710-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> I'm ignorant of RCU, and my mind goes mushy around memory barriers,
> but I expect you've consulted the best there; and I'll be wanting to
> refer to this implementation as a nice example of how to use RCU.

Yes the RCU patch author Dipankar has already reviewed the memory
barriers in ipclock patch.  

> Now delete spinlock_t ary and all references to it: only grow_ary
> is using it, and it's already protected by sem, and we'd be in
> trouble with concurrent allocations if it were not.
> 
Oh, right. grow_ary does not need spinlock_t ary anymore.:-)
