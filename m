Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267341AbSLRUyT>; Wed, 18 Dec 2002 15:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbSLRUyT>; Wed, 18 Dec 2002 15:54:19 -0500
Received: from smtp6.us.dell.com ([143.166.85.135]:28547 "EHLO
	smtp6.us.dell.com") by vger.kernel.org with ESMTP
	id <S267341AbSLRUyS>; Wed, 18 Dec 2002 15:54:18 -0500
Date: Wed, 18 Dec 2002 14:55:13 -0600 (CST)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: robert@ping.us.dell.com
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.47 - Assertion failed in fs/jbd/journal.c:415
In-Reply-To: <3E00DC07.7729E6A2@digeo.com>
Message-ID: <Pine.LNX.4.44.0212181453001.16565-100000@ping.us.dell.com>
X-Complaints-to: /dev/null
X-Apparently-From: mars
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2002, Andrew Morton wrote:
> I can't immediately see what would cause this.  There is code in
> __journal_file_buffer which could have triggered this, but we should
> have exclusion from that via both lock_kernel() and lock_journal().
> 
> I'll see if Stephen can spot it.   I shall assume you were using
> the data-ordered journalling mode.
> 
Correct, I also had them mounted with noatime as well if that matters.

