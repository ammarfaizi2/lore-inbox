Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbTGAASS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 20:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTGAASR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 20:18:17 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:44741 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265178AbTGAASR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 20:18:17 -0400
Date: Tue, 1 Jul 2003 01:32:38 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Paul Larson <plars@linuxtestproject.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.73 Scheduling while atomic with taskfile IO and high
 memory
In-Reply-To: <1057005453.5264.2964.camel@plars>
Message-ID: <Pine.LNX.4.53.0307010130500.22576@skynet>
References: <Pine.LNX.4.53.0306302052520.22576@skynet> <1057005453.5264.2964.camel@plars>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, Paul Larson wrote:

> This sounds similar to what I was seeing with bug #800, only I don't
> think I had taskfile IO enabled.  Another person I talked to had some
> success by enabling PIIX I think, but that did not work for me.  The
> only workaround that worked for me was to disable highmem support.

I'm pretty sure we're looking at the same bug, at least they are
remarkably similar for a co-incidence. If you have the time, it might be
worth checking if commenting out inc_preempt_count() and
dec_preempt_count() from kmap_atomic() and kunmap_atomic() masks the bug
for you. It's not a workaround but it might help narrow down where things
are going wrong

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel
