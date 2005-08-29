Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVH2Whv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVH2Whv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVH2Whu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:37:50 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:27031 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751384AbVH2Whu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:37:50 -0400
Date: Tue, 30 Aug 2005 00:36:37 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Matt Mackall <mpm@selenic.com>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com
Subject: Re: 2.6.13-rc6-rt1
In-Reply-To: <20050827011537.GC27787@waste.org>
Message-Id: <Pine.OSF.4.05.10508300035390.11113-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Matt Mackall wrote:

> On Tue, Aug 16, 2005 at 02:32:01PM +0200, Michal Schmidt wrote:
> > Ingo Molnar wrote:
> > >i've released the 2.6.13-rc6-rt1 tree, which can be downloaded from the 
> > >usual place:
> > >
> > >  http://redhat.com/~mingo/realtime-preempt/
> > >
> > >as the name already suggests, i've switched to a new, simplified naming 
> > >scheme, which follows the usual naming convention of trees tracking the 
> > >mainline kernel. The numbering will be restarted for every new upstream 
> > >kernel the -RT tree is merged to.
> > 
> > Great! With this naming scheme it is easy to teach Matt Mackall's 
> > ketchup script about the -RT tree.
> > The modified ketchup script can be downloaded from:
> > http://www.uamt.feec.vutbr.cz/rizeni/pom/ketchup-0.9+rt
> > 
> > Matt, would you release a new ketchup version with this support for 
> > Ingo's tree?
> 
> Thanks. I've put this in my version, which is now exported as a
> Mercurial repo at:
> 
>  http://selenic.com/repo/ketchup
> 
> This version also has -git support, finally.
> 
I added the line in the patch below to be able to get Ingo's older
patches.

Esben

diff -r 1342be306020 ketchup
--- a/ketchup   Sat Aug 27 01:12:42 2005
+++ b/ketchup   Tue Aug 30 00:30:23 2005
@@ -367,6 +367,7 @@
 
     # the jgarzik memorial hack
     url2 = re.sub("/snapshots/", "/snapshots/old/", url)
+    url2 = re.sub("/realtime-preempt/", "/realtime-preempt/older/", url2)    
     if url2 != url:
         if download(url2, file): return file

