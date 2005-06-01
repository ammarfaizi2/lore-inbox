Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVFAWqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVFAWqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFAWqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:46:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:55237 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261345AbVFAWp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:45:56 -0400
Subject: Re: Freezer Patches.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601223101.GD11163@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost>  <20050601223101.GD11163@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 08:45:33 +1000
Message-Id: <1117665934.19020.94.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 00:31 +0200, Pavel Machek wrote:
> Hi!
> 
> (Well, it is just after midnight here :-).
> 
> > > > Here are the freezer patches. They were prepared against rc3, but I
> > > > think they still apply fine against rc5. (Ben, these are the same ones I
> > > > sent you the other day).
> > > 
> > > 304 seems ugly and completely useless for mainline
> > 
> > That's because you don't understand what it's doing.
> > 
> > The new refrigerator implementation works like this:
> > 
> > Userspace processes that begin a sys_*sync gain the process flag
> > PF_SYNCTHREAD for the duration of their syscall.
> 
> swsusp1 should not need any special casing of sync, right? We can
> simply do sys_sync(), then freeze, or something like that. We could
> even remove sys_sync() completely; it is not needed for correctness.

It's still quite nice to have ... I put it in my pre-freeze callback in
fact for both STR and STD :) We really want it for STD but I think it
doesn't work properly after freeze.

Ben.


