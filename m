Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbTHOQbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbTHOQ3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:29:20 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:32709
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S267520AbTHOQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:28:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] O12.2int for interactivity
Date: Sat, 16 Aug 2003 02:35:04 +1000
User-Agent: KMail/1.5.3
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <200308141659.33447.kernel@kolivas.org> <3F3BE9BD.20304@techsource.com>
In-Reply-To: <3F3BE9BD.20304@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308160235.05105.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 05:57, Timothy Miller wrote:
> > Actually the timeslice handed out is purely dependent on the static
> > priority, not the priority it is elevated or demoted to by the
> > interactivity estimator. However lower priority tasks (cpu bound ones if
> > the estimator has worked correctly) will always be preempted by higher
> > priority tasks (interactive ones) whenever they wake up.
>
> Ok, so tasks at priority, say, 5 are all run before any tasks at
> priority 6, but when a priority 6 task runs, it gets a longer timeslice?

All "nice" 0 tasks get the same size timeslice. If their dynamic priority is 
different (the PRI column in top) they still get the same timeslice.

> How much longer?

Different nice levels are about 5ms apart in size.

Con

