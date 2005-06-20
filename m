Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVFUEo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVFUEo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFTW4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:56:09 -0400
Received: from mail.dif.dk ([193.138.115.101]:14734 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261962AbVFTWIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:08:45 -0400
Date: Tue, 21 Jun 2005 00:14:14 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Greg KH <gregkh@suse.de>, Denis Vlasenko <vda@ilport.com.ua>,
       Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.12 udev hangs at boot
In-Reply-To: <Pine.LNX.4.21.0506201723090.30848-100000@iabervon.org>
Message-ID: <Pine.LNX.4.62.0506210008480.2369@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.21.0506201723090.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Daniel Barkalow wrote:

> On Mon, 20 Jun 2005, Greg KH wrote:
> 
> > On Mon, Jun 20, 2005 at 01:04:10PM +0300, Denis Vlasenko wrote:
> > > 
> > > Greg, any plans to distribute udev and hotplug within kernel tarballs
> > > so that people do not need to track such changes continuously?
> > 
> > Nope.  But if you use udev, you should read the announcements for new
> > releases, as I did say this was required for 2.6.12, and gave everyone a
> > number of weeks notice :)
> 
> Shouldn't this be listed in Changes? It looks like Changes only mentions
> the existance of udev, but doesn't specify a required version, despite
> there being a version requirement. (Not that I really think too many
> people would think to look, but it would at least have a chance of
> reaching people who look carefully at kernels but don't read the mailing
> list)
> 
Sounds like a good idea to me. Here's a patch. Does this look OK to you 
Greg?  
I was tempted to write udev 031 or so, since Documentation/Changes is 
supposed to list absolute minimum versions, and as far as I could read 
from your previous posts 030 would have been the last one with the lock-up 
bug, but then I read this little bit in the udev 058 announcement:
	"Note, if you are running a kernel newer than 2.6.12-rc4 
	 (including the -mm releases) and you have any custom udev rules, 
	 you MUST upgrade to the latest version to allow udev to work 
	 properly."
And given that the latest release at that time was 058 (since this is in 
the announcement of that release), I figured that the minimum requirement 
for flawless operation actually is udev 058 for the 2.6.12 and future 
kernels - so that's what I ended up writing.


Add required udev version to Documentation/Changes

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 Documentation/Changes |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.12-orig/Documentation/Changes	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/Documentation/Changes	2005-06-21 00:07:17.000000000 +0200
@@ -64,6 +64,7 @@
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
 o  oprofile               0.5.3                   # oprofiled --version
+o  udev                   058                     # udevinfo -V
 
 Kernel compilation
 ==================



