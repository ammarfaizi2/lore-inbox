Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVD3Wxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVD3Wxw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 18:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVD3Wxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 18:53:52 -0400
Received: from mail.aei.ca ([206.123.6.14]:43245 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261446AbVD3Wxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 18:53:49 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.12-rc3-mm1
Date: Sat, 30 Apr 2005 18:53:40 -0400
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050429231653.32d2f091.akpm@osdl.org> <200504300827.44359.tomlins@cam.org> <Pine.LNX.4.61.0504301634590.3559@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0504301634590.3559@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504301853.40395.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 April 2005 18:36, Zwane Mwaikambo wrote:
> On Sat, 30 Apr 2005, Ed Tomlinson wrote:
> 
> > If we stick with git it might make sense not to include a linux-patch.  cogito
> > is quite fast to export using a commit id.  Suspect some bandwidth could be 
> > saved if you just stated the commit id that you based the mm patch on.
> > 
> > In case anyone is wondering how build this from a cogito/git db...  Find the
> > cogito announcement on lkml install and update cogito.  Then folliw the instructions
> > in the README and download the kernel's db.  Next search lkml to find the commit id 
> > of rc3 (a2755a80f40e5794ddc20e00f781af9d6320fafb) and verify you have it correct 
> > with:
> > 
> > cg-mkpatch a2755a80f40e5794ddc20e00f781af9d6320fafb
> > 
> > then export a tree with
> > 
> > cg-export ../12-3-1 a2755a80f40e5794ddc20e00f781af9d6320fafb
> > 
> > and cd over to the new dir and patch with mm and have fun.
> 
> That'd be a horribly convoluted procedure and make automation difficult,
> -mm shouldn't be that difficult to use. Also linus.patch used to be the 
> current -bk snapshot.

Huh?  Assuming one already has a current git tree.  Then all Andrew need do
is publish the commit id from Linus then the complicated procedure becomes

cd <checkedout git copy of kernel>
cg-update origin
cg-export ../<work dir> <commit id>
cd ../<work dir>
cp ../<default config> .config
bzcat ../<mm patch> | patch -p1
make oldconfig
make

No problem to script this at all.  Also, I suspect what when tagging starts to be 
used, that <commit id> will be an easily typeable string.

With bk there was an acceptable excuse not to use it.  With git, aside from bandwidth
concerns (maybe mercurial can solve this), I do not see any good reason not to use it.

Ed Tomlinson

