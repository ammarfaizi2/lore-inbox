Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263300AbSJCNbf>; Thu, 3 Oct 2002 09:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263301AbSJCNbf>; Thu, 3 Oct 2002 09:31:35 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:46234 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S263300AbSJCNbe>; Thu, 3 Oct 2002 09:31:34 -0400
Subject: Re: [rfc] [patch] kernel hooks
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Michael Grundy" <vamsi_krishna@in.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, suparna <bsuparna@in.ibm.com>,
       "Suparna Bhattacharya" <bsuparna@in.ibm.com>, vamsi@linux.ibm.com
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFAC358F0A.6BBBEF7D-ON80256C47.004A301E@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Thu, 3 Oct 2002 14:32:50 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/10/2002 14:35:10
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You must also ensure that the code you are modifying isnt on an IRQ path
> (if it is you must do spin locks and then be very careful about cross
> cpu tlb deadlocks). Finally you have no choice but to ensure you never
> use it on the NMI path

Why do we need a spinlock? We change one byte, we are not concered about
when exactly that takes effect, only that there are always valid
instructions in the pipeline.

Richard.

