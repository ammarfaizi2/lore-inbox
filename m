Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752951AbWKFNJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbWKFNJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbWKFNJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:09:03 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:29316 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752951AbWKFNJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:09:02 -0500
X-Sasl-enc: oiDK1BaR5YosGia+2YbnymYwuAqMYMd2Vpaspduzh2pX 1162818542
Subject: Re: [BUG] 2.6.19-rc3 autofs crash on my IA64 box
From: Ian Kent <raven@themaw.net>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "bibo,mao" <bibo.mao@intel.com>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061106214252.3B37.Y-GOTO@jp.fujitsu.com>
References: <20061102183020.446D.Y-GOTO@jp.fujitsu.com>
	 <Pine.LNX.4.64.0611031610070.7573@raven.themaw.net>
	 <20061106214252.3B37.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 21:08:56 +0800
Message-Id: <1162818536.10271.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 21:47 +0900, Yasunori Goto wrote:
> Hi.
> 
> > I've checked this and this is not the only problem.
> > Also autofs4_ is called with s->s_root NULL in this case.
> > 
> > The attached patch ensures that the autofs filesystem is initialized to be 
> > catatonic until super block setup is complete which avoids the problem 
> > above. It also checks s->s_root before use.
> > 
> > Could someone seeing this problem try this patch out please.
> 
> Sorry for late response. I was off.
> I tested your patch on my box. It worked well.

Thanks.

Unfortunately, I've got a couple of other problems.

In my testing I managed to panic the kernel further on, somewhere in
selinux. The scenario is slightly different though, running autofs
version 5 against a version 4 module. I really can't see why, all the
references look OK. I'm not sure what can be done it either as we're
talking about an older kernel anyway.

My other problem is I can't get my -mm kernel to build atm so I can't
really test further. I'm sure that will change soon.

Ian


