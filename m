Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVEANJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVEANJw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 09:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVEANJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 09:09:52 -0400
Received: from mail.aei.ca ([206.123.6.14]:43239 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261607AbVEANJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 09:09:48 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6.12-rc3-mm1
Date: Sun, 1 May 2005 09:09:37 -0400
User-Agent: KMail/1.7.2
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20050429231653.32d2f091.akpm@osdl.org> <Pine.LNX.4.61.0504301700470.3559@montezuma.fsmlabs.com> <20050430161032.0f5ac973.rddunlap@osdl.org>
In-Reply-To: <20050430161032.0f5ac973.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505010909.38277.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 April 2005 19:10, Randy.Dunlap wrote:
> On Sat, 30 Apr 2005 17:05:43 -0600 (MDT) Zwane Mwaikambo wrote:
> 
> | On Sat, 30 Apr 2005, Ed Tomlinson wrote:
> | 
> | > Huh?  Assuming one already has a current git tree.  Then all Andrew need do
> | > is publish the commit id from Linus then the complicated procedure becomes
> | > 
> | > cd <checkedout git copy of kernel>
> | > cg-update origin
> | > cg-export ../<work dir> <commit id>
> | > cd ../<work dir>
> | > cp ../<default config> .config
> | > bzcat ../<mm patch> | patch -p1
> | > make oldconfig
> | > make
> | > 
> | > No problem to script this at all.  Also, I suspect what when tagging starts to be 
> | > used, that <commit id> will be an easily typeable string.
> | 
> | Ok, now tell this to one of the users who tests kernels, now users also 
> | need to know how to use git in order to test -mm. I'm thinking about the 
> | case where someone reports a bug on LKML and we ask that they test latest 
> | -mm, getting them to also understand git just to quickly test something is 
> | silly. Also people tend to have other things to do so making things 
> | even slightly more difficult doesn't win you testers. Maybe i'm just 
> | lazy... *shrug*
> 
> Nope, you are correct...

Actually you can look at this either way.  Consider, you ask someone to test mm and
they have not built a kernel before.  So they have to:

download a base kernel, untar it.
download a RCx patch and apply it
download the mm patch and apply it
take their current /proc/config.gz and place it in the current dir as .config
make oldconfig
make and install the kernel

using cogito in a few weeks this will translate to

install a distro package for cogito, which will probably give you the option of downloading the kernel.
export an RCx directory treedownload the mm patch and apply it
take their current /proc/config.gz and place it in the current dir as .config
make oldconfig
make and install the kernel

Which is a simpler process...   Its just different.   

BTW the most complex process, from a unexperienced user POV, is probably the 
make oldconfig as most distros automate the build and install.

There is no point in going any further with this.  We will have to see what 
happens on the SCM front.  What would be interesting is if the quilt scripts
were integrated into the SCM.  Then Andrew would just have to publish a
commit id (or quilt id?).

Ed Tomlinson






