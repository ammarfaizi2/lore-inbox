Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbTCZQLs>; Wed, 26 Mar 2003 11:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbTCZQLs>; Wed, 26 Mar 2003 11:11:48 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:26844 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261758AbTCZQLr>; Wed, 26 Mar 2003 11:11:47 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] s390 update (1/9): s390 arch fixes.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF80FD93D6.AA8C5DBA-ONC1256CF5.00589668@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 26 Mar 2003 17:20:39 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 26/03/2003 17:22:10
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It looks you do exactly the same changes to both s390 and s390x.  A
closer
> look at the arch directories shows that about 95% of the code is exactly
> the same.  Can you remove the s390x dir and abstract out the few
differences
> into a config option?

s390 and s390x are similar at the first glance. But if you look in detail
you will notice that there are a lot of small differences. A simple diff
of the files that are present in both arch folger gives a patch of 5600
lines. Compare this to the 11500 lines these files have in total. So the
code is definitly NOT 95% the same. Further the arch folder is not the
only place to look for s390 files. You need to consider include/asm
as well. Overall it is not an easy task. You have a point though that it
would be very nice to have common files for all s390/s390x files, not just
for the device drivers. If I have lots of time someday I probably will
try it but for now it way too much effort.

blue skies,
   Martin


