Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbTLWBYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 20:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTLWBYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 20:24:53 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:60110
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264913AbTLWBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 20:24:52 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Tue, 23 Dec 2003 12:24:48 +1100
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200312231138.21734.kernel@kolivas.org> <3FE79626.1060105@cyberone.com.au>
In-Reply-To: <3FE79626.1060105@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231224.49069.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 12:11, Nick Piggin wrote:
> I think this patch is much too ugly to get into such an elegant scheduler.
> No fault to you Con because its an ugly problem.

You're too kind. No it's ugly because of my code but it works for now.

> How about this: if a task is "delta" priority points below a task running
> on another sibling, move it to that sibling (so priorities via timeslice
> start working). I call it active unbalancing! I might be able to make it
> fit if there is interest. Other suggestions?

I discussed this with Ingo and that's the sort of thing we thought of. Perhaps 
a relative crossover of 10 dynamic priorities and an absolute crossover of 5 
static priorities before things got queued together. This is really only 
required for the UP HT case.

Con

