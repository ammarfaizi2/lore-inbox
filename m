Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965331AbWIVXDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbWIVXDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWIVXDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:03:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965331AbWIVXDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:03:47 -0400
Date: Fri, 22 Sep 2006 16:02:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Daniel R Thompson <daniel.thompson@st.com>,
       Jon Smirl <jonsmirl@gmail.com>
Subject: Re: backlight: oops in __mutex_lock_slowpath during head
 /sys/class/graphics/fb0/* in 2.6.18
Message-Id: <20060922160255.b97f2887.akpm@osdl.org>
In-Reply-To: <20060922112622.GA26724@aepfle.de>
References: <20060921121952.GA16927@aepfle.de>
	<20060921123742.ec225cc2.akpm@osdl.org>
	<20060921215620.GA9518@hansmi.ch>
	<20060922112622.GA26724@aepfle.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 13:26:22 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> On Thu, Sep 21, Michael Hanselmann wrote:
> 
> > What about the patch below? Does it work for you?
> 
> Appears to work.
> 
> tangerine:~ # head /sys/class/graphics/fb0/*
> ==> /sys/class/graphics/fb0/bits_per_pixel <==
> 8
> 
> ==> /sys/class/graphics/fb0/bl_curve <==
> head: error reading `/sys/class/graphics/fb0/bl_curve': No such device
> 
> ==> /sys/class/graphics/fb0/blank <==
> 
> ==> /sys/class/graphics/fb0/console <==
> 
> ==> /sys/class/graphics/fb0/cursor <==
> 
> ==> /sys/class/graphics/fb0/dev <==
> 29:0
> 
> ==> /sys/class/graphics/fb0/mode <==
> 
> ==> /sys/class/graphics/fb0/modes <==
> U:832x624p-74
> 
> ==> /sys/class/graphics/fb0/name <==
> valkyrie
> 
> ==> /sys/class/graphics/fb0/pan <==
> 0,0
> 
> ==> /sys/class/graphics/fb0/rotate <==
> 0
> 
> ==> /sys/class/graphics/fb0/state <==
> 0
> 
> ==> /sys/class/graphics/fb0/stride <==
> 832
> 
> ==> /sys/class/graphics/fb0/subsystem <==
> head: error reading `/sys/class/graphics/fb0/subsystem': Is a directory
> head: cannot open `/sys/class/graphics/fb0/uevent' for reading: Permission denied
> 
> ==> /sys/class/graphics/fb0/virtual_size <==
> 832,624

Still looks like a bit of a mess, but I assume that's expected.

Michael, I take it that patch was final?
