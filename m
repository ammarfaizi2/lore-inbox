Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbTCQIhM>; Mon, 17 Mar 2003 03:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTCQIhM>; Mon, 17 Mar 2003 03:37:12 -0500
Received: from 237.oncolt.com ([213.86.99.237]:62164 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262656AbTCQIhL>; Mon, 17 Mar 2003 03:37:11 -0500
Subject: RE: [PATCH] Fix stack usage for amd_flash.c
From: David Woodhouse <dwmw2@infradead.org>
To: Jonas Holmberg <jonas.holmberg@axis.com>
Cc: "'Joern Engel'" <joern@wohnheim.fh-wedel.de>,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB01CAF576@mailse01.se.axis.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB01CAF576@mailse01.se.axis.com>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1047890876.28282.5.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 17 Mar 2003 08:47:56 +0000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-17 at 08:36, Jonas Holmberg wrote:
> [ Jörn Engel wrote: ]
> > On Fri, 14 March 2003 16:05:10 +0000, David Woodhouse wrote:
> > > Also note that all but the CFI-based drivers are deprecated. We have
> > > old-style probes which allow us to use the CFI back-end drivers with
> > > non-CFI chips anyway.
> > 
> > Right. But since 2.[567] is going towards 4k kernel stack, those
> > drivers should be fixed or revomed. If you don't remove it, I'll try
> > to fix it. :)
> 
> We're still using the amd_flash-driver a lot because I haven't got time
> to try out the jedec_probe since the toggle-bit stuff was added in the
> CFI driver. 

Yep, that's why I haven't actually _removed_ the other drivers; just
marked them deprecated. I'm sort of planning to remove them in 2.7.

> I made some rough tests just before that, and jedec_probe +
> CFI driver turned out to be much slower than amd_flash. But then the CFI
> driver was modified... I'll try to get some time to test them again soon
> and maybe even do something about it.

That'd be useful -- thanks. The CFI cmdset 0002 driver could do with a
little more loving :) 

Btw, your mail landed in my spam folder and got bounced from the MTD
list due to missing In-Reply-To: and References: headers. 

-- 
dwmw2

