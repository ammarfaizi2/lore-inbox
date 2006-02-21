Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWBUVm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWBUVm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWBUVm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:42:58 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:16319
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750880AbWBUVm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:42:57 -0500
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
From: Paul Fulghum <paulkf@microgate.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
	 <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 15:42:41 -0600
Message-Id: <1140558161.9838.8.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 22:10 +0100, Jesper Juhl wrote:

> I should probably mention that the kernel I'm currently running and
> observing this behaviour with is 2.6.16-rc4-mm1.
...
> > I find this quite strange since anything from 'make -j 2' and up
> > should be able to keep both cores resonably busy, but there seems to
> > be a huge difference between j <= 4 and j > 4.

I've seen the same thing (on Athlon 64x2 64 bit)
but was not sure if it was a problem.

The break point for me seems to be between -j 2 and -j 3
-j 2 = serialized (or the appearance of)
-j 3 = both cores mostly busy

I'm pretty sure with an earlier 2.6 kernel source (but same environment)
I did not see this. I'll start back tracking to earlier kernels
to see if I can identify when this started.

-- 
Paul Fulghum
Microgate Systems, Ltd

