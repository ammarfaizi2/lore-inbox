Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSIBMu0>; Mon, 2 Sep 2002 08:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSIBMuZ>; Mon, 2 Sep 2002 08:50:25 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:23031 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318291AbSIBMuZ>; Mon, 2 Sep 2002 08:50:25 -0400
Importance: Normal
MIME-Version: 1.0
Sensitivity: 
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at page_alloc.c:91! (2.4.19)
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB29A6613.5FAAE384-ONC1256C28.00430C8B@de.ibm.com>
From: "Heiko Carstens" <Heiko.Carstens@de.ibm.com>
Date: Mon, 2 Sep 2002 14:54:47 +0200
X-MIMETrack: Serialize by Router on D12ML032/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 02/09/2002 14:54:48,
	Serialize complete at 02/09/2002 14:54:48
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

>> Looks to me that this function itself has a bug: after the drop_pte 
label
>> it is checked if the current page has a mapping. If this is true there 
is
>> ...
>Chances are, you've run into the subtle double-free race I've been 
working
>on for the last few days.  Would you like to try this patch as see if it
>makes a difference?
>http://nl.linux.org/~phillips/patches/lru.race-2.4.19

Thanks for the patch but unfortunately it doesn't change the behaviour at
all. This BUG is still 100% reproducible by just having 1 process which
allocates memory chunks of 256KB and after each allocation writes to each
of the pages in order to make them dirty.

regards,
Heiko

