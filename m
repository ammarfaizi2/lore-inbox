Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271848AbTHHTOr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272050AbTHHTOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:14:46 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:46982
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S271848AbTHHTOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:14:44 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: mouse and keyboard by default if not embedded
Date: Fri, 8 Aug 2003 06:27:51 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307272003.h6RK3ckm029604@hraefn.swansea.linux.org.uk> <20030728081447.B1707@infradead.org>
In-Reply-To: <20030728081447.B1707@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308080627.52112.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 03:14, Christoph Hellwig wrote:
> Again this is stupid.  With the select CONFIG_INPUt if CONFIG_VT people
> get this asked now on make oldconfig.  Even more important many ports
> newer used PS/2 style mouses previously as did older PeeCees.
>
> Please stop this over-eager spreading of CONFIG_EMBEDDED, we're not
> gnome..

Actually, I was going to move all this stuff to the embedded menu as soon as I 
caught up on Linux-kernel to make sure nobody else had already done it.  (I 
was only 2500 messages behind the day before yesterday, but people keep 
posting more... :)

Finding out that Alan beat me to this is exactly why I'm catching up on my 
reading before pushing patches. :)

The 2.5 kernel I just compiled is currently about three times larger than the 
uclibc+busybox root filesystem I built yesterday.  I'm all for stripping it 
down, but saying that your average server doesn't need the ability to plug in 
a monitor and keyboard and see what's up if it suddenly goes peculiar...  
Well, I wouldn't want to support that system, and certainly Red Hat ain't 
gonna ship like that any time soon.  (As for the servers you mentioned in 
your previous post, we're potentially saving tens of kilobytes by doing so, 
on a system with around gigabyte of ram.  So if we're saving 10-30k (not just 
kernel code but run-time allocations), we're talking about saving 0.001 to 
0.003% of ram on a server setup.  Oooh.  Aaaah.  Definitely the kind of 
micro-optimization we want everybody in the world (and their dog) to have to 
figure out if they need or not the first time they compile a kernel.)

Rob
