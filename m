Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUIOSOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUIOSOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUIOSKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:10:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:16608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267301AbUIOSJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:09:17 -0400
Date: Wed, 15 Sep 2004 11:09:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nikita Danilov <nikita@clusterfs.com>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <16712.32725.515306.890990@thebsh.namesys.com>
Message-ID: <Pine.LNX.4.58.0409151108080.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org> <16712.32725.515306.890990@thebsh.namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2004, Nikita Danilov wrote:
> 
> Unfortunately it breaks even better identity
> 
>   foo *p;
> 
>   p + nr == (foo *)((char *)p + nr * sizeof *p)

No, gcc allows the above, by making sizeof(void) be 1.

And sane compilers would just inform the user at compile-time with a nice
readable message that he's doing something stupid.

		Linus
