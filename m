Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319004AbSHMUcg>; Tue, 13 Aug 2002 16:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319011AbSHMUcg>; Tue, 13 Aug 2002 16:32:36 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:46330 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319004AbSHMUcf>; Tue, 13 Aug 2002 16:32:35 -0400
Subject: Re: [PATCH] NUMA-Q disable irqbalance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0208131332440.1265-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208131332440.1265-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 21:34:02 +0100
Message-Id: <1029270842.21007.113.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 21:35, Linus Torvalds wrote:
> Now, there have been other changes too - like the scheduler (and my
> current P4 has a different SCSI interface), but I dunno. The thing I 
> attributed the improvements in interactive feel was the fact that the work 
> got balanced out more sanely.

I've been benching 2.4 with the O(1) scheduler and the process load
balancing changes and seeing this. Conceptually I can understand why it
would occur (cache affinity) but if so we ought to do some much slower
(maybe once every 5 seconds based on accumulated averages) balancing not
none

