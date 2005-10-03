Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVJCVHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVJCVHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVJCVHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:07:15 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:42183 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932432AbVJCVHO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:07:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HWAHsIUxW+6mATQ3vsp/vKPA+86DR69iyM/a6Mz5M/io2sW6yc7YWilrZaI+v+RwNrEa8ItVUOKQoHcWIQIpYM2vqOamacPYJXQhjqyLgseB/BoF0AoHiKsARd1mAbHXuyXlcQ/rjYX3AzIBKR6dgoiljpuEJrOAW8XiKNwC4b0=
Message-ID: <12c511ca0510031407i5266cf4ak5082ec54f60a3d17@mail.gmail.com>
Date: Mon, 3 Oct 2005 14:07:12 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] kill include/linux/platform.h
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051003190345.GH3652@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050902205204.GU3657@stusta.de>
	 <Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net>
	 <20051001233414.GG4212@stusta.de>
	 <12c511ca0510031201x1f66300bucaff6410e7b675bb@mail.gmail.com>
	 <20051003190345.GH3652@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The default_idle() prototype should stay inside some header file.

That would be best, yes.

> @Patrick:
> Any suggestion where it should move to?

Of the include files already included directly by arch/ia64/kernel/setup.c,
<linux/sched.h> looks the most promising.  There's lots of .*idle.* things
already in there.

Looking at existing precedent: ppc64 has a definition of default_idle()
in <asm/machdep.h>

i396, cris and um already have gone along the route of adding extern
definitions for default_idle() to ".c" files ... so cleanup creates more
opportunities for cleanup (but you are probably very experienced in
this phenomenom :-)

-Tony
