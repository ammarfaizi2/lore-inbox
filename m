Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVHRVnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVHRVnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVHRVnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:43:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:15064 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932476AbVHRVnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:43:14 -0400
Subject: Re: pmac_nvram problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1124370184.30888.5.camel@localhost>
References: <1124277416.6336.11.camel@localhost>
	 <1124341212.8848.78.camel@gaston>  <1124370184.30888.5.camel@localhost>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 07:40:26 +1000
Message-Id: <1124401227.5182.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 15:03 +0200, Johannes Berg wrote:
> On Thu, 2005-08-18 at 15:00 +1000, Benjamin Herrenschmidt wrote:
> 
> > There used to be cases where we used the nvram stuff before kmalloc()
> > was available. I'll check if this is still the case.
> 
> Ah, ok. Makes sense. In that case I suppose it must be #ifdef'ed for the
> module case.
>  
> > Well... the driver doesn't expect you to boot a different OS while
> > suspended to disk :)
> 
> Yeah :) It'd be nice though since except for that I haven't found any
> other adverse effects.
> 
> > Regarding caching the data in memory, this is done becaues nvram is
> > actually a flash on recent machines, and you really want to limit the
> > number of write cycles to it.
> 
> Ok, makes sense. When I get some time I'll look into converting and
> implementing reloading for that case, but now that I compile as a module
> and unload it, it hardly is a priority.

Just a question: Why do you want to have the nvram low level code as a
module ? It's sort-of an intergral part of the arch code ...

Ben.


