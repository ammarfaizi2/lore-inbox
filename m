Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTIDCRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTIDCRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:17:38 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:15831 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S264486AbTIDCRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:17:37 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Scaling noise
Date: Thu, 4 Sep 2003 04:21:16 +0200
User-Agent: KMail/1.5.3
Cc: Larry McVoy <lm@bitmover.com>, Nick Piggin <piggin@cyberone.com.au>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <31190000.1062604245@[10.10.2.4]> <20030904004943.GB5227@work.bitmover.com>
In-Reply-To: <20030904004943.GB5227@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309040421.16939.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 02:49, Larry McVoy wrote:
> It's much better to have a bunch of OS's and pull
> them together than have one and try and pry it apart.

This is bogus.  The numbers clearly don't work if the ccCluster is made of 
uniprocessors, so obviously the SMP locking has to be implemented anyway, to 
get each node up to the size just below the supposed knee in the scaling 
curve.  This eliminates the argument about saving complexity and/or work.

The way Linux scales now, the locking stays out of the range where SSI could 
compete up to, what?  128 processors?  More?  Maybe we'd better ask SGI about 
that, but we already know what the answer is for 32: boring old SMP wins 
hands down.  Where is the machine that has the knee in the wrong part of the 
curve?  Oh, maybe we should all just stop whatever work we're doing and wait 
ten years for one to show up.

But far be it from me to suggest that reality should intefere with your fun.

Regards,

Daniel

