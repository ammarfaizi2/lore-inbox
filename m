Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbSJUUcP>; Mon, 21 Oct 2002 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSJUUcP>; Mon, 21 Oct 2002 16:32:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:16600 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261625AbSJUUcO>; Mon, 21 Oct 2002 16:32:14 -0400
Message-ID: <3DB464B9.7B44EB48@us.ibm.com>
Date: Mon, 21 Oct 2002 13:34:01 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]IPC locks breaking down with RCU
References: <Pine.LNX.4.44.0210212056390.17270-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> In the original design, Mingming nicely split up the locks (greatly
> reducing contention), but had them in an array (causing lots of bounce,
> I believe): 
I am not an expert of cacheline bouncing, so please point me if I miss
something.  I wonder if we could reduce the bounce even with current
design (the spinlock is in the data it protects).  We have to go through
that array anyway to get access to the data (and the spinlock).

> I'm resisting a return to that design.
OK, I will back to original design.
