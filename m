Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUEaNdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUEaNdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUEaNdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:33:50 -0400
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:5060 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263019AbUEaNds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:33:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Tvrtko A. =?utf-8?q?Ur=C5=A1ulin?=" <tvrtko.ursulin@zg.htnet.hr>
Subject: Re: MM patches (was Re: why swap at all?)
Date: Mon, 31 May 2004 23:33:43 +1000
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <40B84C85.8010207@yahoo.com.au> <200405311513.32930.tvrtko.ursulin@zg.htnet.hr>
In-Reply-To: <200405311513.32930.tvrtko.ursulin@zg.htnet.hr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405312333.43188.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004 23:13, Tvrtko A. Uršulin wrote:
> On Saturday 29 May 2004 10:40, Nick Piggin wrote:
> > It is a cocktail of cleanups, simplification, and enhancements. The
> > main ones that applie here is my split active lists patch (search
> > archives for details), and explicit use-once logic.
>
> I didn't have time to personally test it but just want to share some
> thoughts. This kind of improvement is absolutely necessary for 2.6 to be
> usefull on the desktop. It continues to escape me how come that this kind
> of, almost, bugfix arrives so late during stable period.
>
> Unfortunately it doesn't apply on top of Con's autoregulate swappines (AM
> from now on) which I am currently testing. AM also does an excellent job in
> preventing swap trashing while doing a lot of filesystem reading.
>
> I am curious on how does your patch technically relates to Con's AM, and is
> it possible to merge the two? I know that they do their job on completely
> different ways, so the real question would be: Is there a need for
> something like AM if using your patch, or it completely obsoletes it?

I had a quick look at Nick's patches to see for you and it appears that Nick's 
work completely removes the swappiness dial and introduces a different metric 
called vm_mapped_page_cost which is not interchangeable with the swappiness 
value. ie they cannot work together, sorry.

Con
