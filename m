Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269316AbUIIEYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269316AbUIIEYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 00:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269334AbUIIEYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 00:24:15 -0400
Received: from main.gmane.org ([80.91.224.249]:37568 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269316AbUIIEYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 00:24:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: [BUG] r200 dri driver deadlocks
Date: Thu, 09 Sep 2004 10:24:21 +0600
Message-ID: <cholt7$uuj$1@sea.gmane.org>
References: <d577e569040904021631344d2e@mail.gmail.com>	 <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>	 <d577e56904090413365f5e223d@mail.gmail.com>	 <1094366099.31457.112.camel@admin.tel.thor.asgaard.local>	 <d577e56904090501224f252dbc@mail.gmail.com>	 <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>	 <d577e569040905131870fa14a3@mail.gmail.com>	 <1094429682.29921.6.camel@krustophenia.net>	 <d577e569040906040147c2277f@mail.gmail.com>	 <1094494329.31464.187.camel@admin.tel.thor.asgaard.local> <d577e5690409070207448961a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 51-150.dial.utk.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <d577e5690409070207448961a4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland wrote:
> On Mon, 06 Sep 2004 14:12:08 -0400, Michel Dänzer <michel@daenzer.net> wrote:
> 
>>You can test the r200_dri.so from the snapshot with the DRM from the
>>kernel...
> 
> 
> And drum roll please...

Too early :(

> The dri cvs snapshot works fine on both it's own kernel module, and
> the one that comes
> with 2.6.8.1. So now what? (And does this mean it isn't a kernel bug?)

I have compiled both the kernel module and the replacement X server from 
the yesterday's CVS checkout of DRI (but according to "outdated" 
instructions in the Wiki). It made a difference against XFree86 4.4.0 + 
in-kernel radeon.ko.

The difference is that, instead of just hanging, after several minutes 
of run time applications (e.g. "really slick screensavers") print:

drmRadeonIrqWait: -16

and exit with status 1.

After that, 2D works, but the _next_ fullscreen OpenGL application hangs 
the system immediately on start.

-- 
Alexander E. Patrakov

