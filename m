Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbVIOQir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbVIOQir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbVIOQir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:38:47 -0400
Received: from smtp-out-02.utu.fi ([130.232.202.172]:18411 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S1030526AbVIOQiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:38:46 -0400
Date: Thu, 15 Sep 2005 19:38:34 +0300
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: 2.6.14-rc1 load average calculation broken?
In-reply-to: <43296BCE.9020700@ppp0.net>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200509151938.36316.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <43295E30.7030508@ppp0.net> <43296BCE.9020700@ppp0.net>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 15:40, Jan Dittmer wrote:
> Jan Dittmer wrote:
> > Get a steady 2.00 there. I stopped unnecessary processes etc.
> > load average seems to be invariant
> >
> > top - 13:41:32 up  4:44,  2 users,  load average: 2.00, 2.00, 2.00
> > Tasks: 108 total,   2 running, 105 sleeping,   0 stopped,   1 zombie
> > Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 99.7% id,  0.3% wa,  0.0% hi,  0.0% si
> 
> Hmm, reboot to 2.6.14-rc1-git1 cured it. Will see if it happens again.
> (btw. it was not invariant but the lower limit was 2 even after stopping
> everything but some essential processes (ssh, init, getty))

Did you check with ps aux, if there were processes stuck in D state? Those
count towards the load average...

