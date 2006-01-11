Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWAKRL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWAKRL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWAKRL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:11:56 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59806 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751503AbWAKRL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:11:56 -0500
Subject: Re: OT: fork(): parent or child should run first?
From: Lee Revell <rlrevell@joe-job.com>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: Arjan van de Ven <arjan@infradead.org>, lgb@lgb.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <4653C70B-04C2-4165-A073-24C6CD21214E@e18.physik.tu-muenchen.de>
References: <20060111123745.GB30219@lgb.hu>
	 <1136983910.2929.39.camel@laptopd505.fenrus.org>
	 <4653C70B-04C2-4165-A073-24C6CD21214E@e18.physik.tu-muenchen.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 12:11:53 -0500
Message-Id: <1136999513.27255.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 14:34 +0100, Roland Kuhn wrote:
> Hi Arjan!
> 
> On 11 Jan 2006, at 13:51, Arjan van de Ven wrote:
> 
> > you just cannot depend on which would run first, child or parent. Even
> > if linux would do it the other way around, you have no guarantee.  
> > Think
> > SMP or Dual Core processors and time slices and cache misses... your
> > code just HAS to be able to cope with it. Even on solaris ;)
> 
> That means that the starting of the child process needs to be  
> synchronized by the application itself. I tried it once but then I  
> discovered that my case was easily solved in a completely different  
> way (it was a very small project). However, which one is the easiest/ 
> fastest way to do this synchronization? Using SysV-Semaphores? Pipes?  
> Would something like this work?

How about POSIX process-shared mutexes?  There's no documentation
avalable on using them with Linux (where are the NPTL man pages
already?) but they work.

Lee

