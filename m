Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318806AbSICRLs>; Tue, 3 Sep 2002 13:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSICRLs>; Tue, 3 Sep 2002 13:11:48 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:4257 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318806AbSICRLq>; Tue, 3 Sep 2002 13:11:46 -0400
Importance: Normal
MIME-Version: 1.0
Sensitivity: 
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at page_alloc.c:91! (2.4.19)
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF3A6E6F2C.2609CEE7-ONC1256C29.005E7DDC@de.ibm.com>
From: "Heiko Carstens" <Heiko.Carstens@de.ibm.com>
Date: Tue, 3 Sep 2002 19:16:01 +0200
X-MIMETrack: Serialize by Router on D12ML032/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/09/2002 19:16:12,
	Serialize complete at 03/09/2002 19:16:12
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Thanks for the patch but unfortunately it doesn't change the behaviour 
at
>> all. This BUG is still 100% reproducible by just having 1 process which
>> allocates memory chunks of 256KB and after each allocation writes to 
each
>> of the pages in order to make them dirty.
>Um, no smp --> no free race anyway.  But try the following instead, to
>start narrowing down the possibilities:

Still the same BUG in __free_pages_ok happens, or in other words both of 
your
checks didn't catch the error...
Any other ideas?

Regards,
Heiko

