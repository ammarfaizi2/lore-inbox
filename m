Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSL2Vak>; Sun, 29 Dec 2002 16:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSL2Vak>; Sun, 29 Dec 2002 16:30:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:65269 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261701AbSL2Vak>;
	Sun, 29 Dec 2002 16:30:40 -0500
Message-ID: <3E0F6B6B.2FCEC917@digeo.com>
Date: Sun, 29 Dec 2002 13:38:51 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more deprectation bits
References: <20021229215554.A11360@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2002 21:38:55.0158 (UTC) FILETIME=[AFE75D60:01C2AF82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> Rename the deprecated attribute to __deprecated to make it obvious
> this is something special and to avoid namespace clashes.
> 
> Mark more functionality deprecated:
> 
>  - sleep_on & friends

Please do not make sleep_on() generate a warning.  Unless you intend
to do the same to lock_kernel().

ext3 uses sleep_on().  It is perfectly safe.   Weaning ext3 off lock_kernel()
is a large, delicate and thus-far undesigned body of work.  I've been
working on other stuff and it is quite unlikely that ext3 locking will
be redesigned in the 2.5 timeframe.

>  - old module interfaces
> 
> This gives quite a lot warnings, I'll start to fix the ones in
> core code and stuff I maintain now..

Sounds like pointless churn to me.  How about we fix some real stuff and get
this kernel out the door before we all die?
