Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265451AbSKFAbS>; Tue, 5 Nov 2002 19:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSKFAbS>; Tue, 5 Nov 2002 19:31:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:30630 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265451AbSKFAbR>;
	Tue, 5 Nov 2002 19:31:17 -0500
Message-ID: <3DC8645B.A0E99A99@digeo.com>
Date: Tue, 05 Nov 2002 16:37:47 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 - hang with processes stuck in D
References: <200211060025.gA60P6V01413@karaya.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 00:37:47.0472 (UTC) FILETIME=[BA8E0500:01C2852C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> 
> 2.4.20-rc1 reliably gets processes stuck in D, eventually wedging the whole
> system.  This is by diffing two kernel pools, one of which has 9 138764288
> byte core files.
> 
> The diff itself is stuck in __wait_on_buffer:
> 
>         Trace; c0131608 <__wait_on_buffer+68/90>

Kernel is waiting for IO completion on a read.  I would be
suspecting your IO system, or interrupt system.

Reverting your ide/scsi/whatever drivers to the last-known-to-work
version would be interesting.
