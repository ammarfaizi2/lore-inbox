Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTEYEXC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 00:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTEYEXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 00:23:02 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:5004 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261323AbTEYEXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 00:23:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Date: Sun, 25 May 2003 14:37:57 +1000
User-Agent: KMail/1.5.1
Cc: Christian Klose <christian.klose@freenet.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305231405.54599.christian.klose@freenet.de> <200305251127.40516.kernel@kolivas.org> <20030525042803.GA8978@holomorphy.com>
In-Reply-To: <20030525042803.GA8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305251437.57464.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003 14:28, William Lee Irwin III wrote:
> On Sun, May 25, 2003 at 11:27:20AM +1000, Con Kolivas wrote:
> > Even though you're not Marc I do agree with you. The problem is well
> > described as either poor interactivity (the window wiggle test) or
> > starvation in the presence of certain scheduler hogs (for whatever
> > reason) since the interactivity patch from mingo. Dropping the max
> > timeslice is a bandaid but destroys priority based timeslice
> > scheduling. Dropping the min timeslice will bring this back, but at
> > some point the timeslice will be so low that low priority cpu
> > intensive tasks will spend most of their time cache trashing.
>
> The fact that it's a "bandaid" and that it "destroys priority-based
> timeslice scheduling" makes it a shenanigan. If you're having problems

I don't disagree it's a shenanigan.

> solved by capping timeslices, you have someone's timeslice and/or
> priority growing too large for some reason.

So there is a benefit to timeslices being as large as 200ms? I'll take your 
word for it.

> It'd be far better to help figure out what went wrong.

Love to help. No idea where to begin. All we can do is report what helps the 
symptoms and hope those in the know can decipher it from that.

Con
