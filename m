Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVHXPu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVHXPu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVHXPu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:50:29 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6814 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751079AbVHXPu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:50:29 -0400
Subject: Re: VIA Rhine ethernet driver bug (reprise...)
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <200508231221.59299.vda@ilport.com.ua>
References: <430A0B69.1060304@xs4all.nl>
	 <200508231221.59299.vda@ilport.com.ua>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 11:50:23 -0400
Message-Id: <1124898624.3855.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 12:21 +0300, Denis Vlasenko wrote:
> My suggestion was, and still is:
> 
> >Since it happens less than once a day, why not just add a code
> >to reset the NIC completely in this case, like it is
> >typically done in tx_timeout handlers of many NICs, and forget about
> it?
> 
> Do you see any problems in this approach? 

Yes, hacks like that often causes a long non-preemptible section because
code that was only intended to run on boot now gets hung off a timer and
can run in the middle of real work.

I have an EPIA 6000 with a via Rhine and I've never seen this bug, so it
must be something specific to your network.  Better to find the bug and
fix it rather than add stupid hacks.

Lee

