Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVFBISb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVFBISb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFBISa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:18:30 -0400
Received: from [203.171.93.254] ([203.171.93.254]:21733 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261234AbVFBIRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:17:44 -0400
Subject: Re: Freezer Patches.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1117697772.31082.54.camel@gaston>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz>
	 <1117665934.19020.94.camel@gaston> <20050601230235.GF11163@elf.ucw.cz>
	 <1117676753.10888.105.camel@localhost> <20050602071431.GA1841@elf.ucw.cz>
	 <1117697187.10888.138.camel@localhost>  <20050602073119.GC1841@elf.ucw.cz>
	 <1117697772.31082.54.camel@gaston>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1117700339.10888.141.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 02 Jun 2005 18:18:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben.

On Thu, 2005-06-02 at 17:36, Benjamin Herrenschmidt wrote:
> Whatever you guys decide to do (I actually do sys_sync() before freezing
> on pmac and yes, it takes sometimes way too long), to be uber-safe, we
> could/should _also_ do sync after freezing userland processes and before
> freezing kernel threads (that is, splitting here). In fact, that would
> help also avoid deadlocks where a frozen kernel thread is holding a
> semaphore preventing a process from freezing.
> 
> That way, if we sys_sync() once processes are sleeping and before kernel
> threads are, we pretty-much make sure no new dirty buffer will appear.
> 
> Anyway, that's mostly food for thoughts at this point

I fully agree, and that's what I'm already doing. Nothing I can do about
Pavel not seeing logic, so guess I just have to hope everyone else does
:)

Regards,

Nigel

