Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422914AbWJQEPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422914AbWJQEPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWJQEPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:15:46 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:32683 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1161094AbWJQEPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:15:45 -0400
X-Sasl-enc: yaWRkHa/uHTmYJDXtK4ujbo89fxvimskiwMWnMn9Y3DH 1161058545
Subject: Re: BUG dcache.c:613 during autofs unmounting in 2.6.19rc2
From: Ian Kent <raven@themaw.net>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200610161658.58288.ak@suse.de>
References: <200610161658.58288.ak@suse.de>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 12:15:35 +0800
Message-Id: <1161058535.11489.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 16:58 +0200, Andi Kleen wrote:
> While unmounting autofs on shutdown my workstation got a dcache.c:613 BUG 
> with 2.6.19rc2.
> 
> Only jpegs available unfortunately:
> 
> http://one.firstfloor.org/~andi/autofs-oops1.jpg
> http://one.firstfloor.org/~andi/autofs-oops2.jpg
> 
> I think it was autofs3 instead of autofs4 - at least I got both compiled in.
> The autofs user land was autofs-4.1.4 (-6 suse rpm) 

Don't think compiling both in is a good idea.
They both register as "autofs" so you really should choose one and
disable the other.

For my part I have to recommend autofs4 (personally I'd like to see the
autofs v3 module deprecated) and autofs4 is really needed if your using
autofs version 4 or above.

Ian


