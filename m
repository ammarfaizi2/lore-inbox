Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319002AbSHMQ42>; Tue, 13 Aug 2002 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319003AbSHMQ42>; Tue, 13 Aug 2002 12:56:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:43256 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319002AbSHMQ41>; Tue, 13 Aug 2002 12:56:27 -0400
Subject: Re: [PATCH] NUMA-Q disable irqbalance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208130937050.7411-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208130937050.7411-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 17:57:46 +0100
Message-Id: <1029257866.20980.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 17:41, Linus Torvalds wrote:
> Finally, exactly since IRQ balancing is practically required on P4-SMP, I
> really don't think a CONFIG option works. It needs to be configured in on
> any kernel that expects to use P4's in an SMP configuration.
> 
> In other words, I think this needs to do a dynamic disable (with the 
> possible exception of a NUMA-Q machine, since that one is already a static 
> config option and won't have P4's in it).

In the 2.4-ac tree it is a dynamic disable keyed off the mp 1.4 tables.
That's how James Cleverdon (I think it was he) implemented the detection
logic and mixed summit/sane-pc kernel build that seems to work well now


