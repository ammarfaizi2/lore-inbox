Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWDEGEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWDEGEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 02:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDEGEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 02:04:45 -0400
Received: from koto.vergenet.net ([210.128.90.7]:54205 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751107AbWDEGEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 02:04:45 -0400
Date: Wed, 5 Apr 2006 14:57:54 +0900
From: Horms <horms@verge.net.au>
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, ebiederm@xmission.com
Subject: Re: [PATCH] kexec: typo in machine_kexec()
Message-ID: <20060405055754.GA3277@verge.net.au>
References: <20060404234806.GA25761@verge.net.au> <200604051310.55956.kernel@kolivas.org> <20060404234806.GA25761@verge.net.au> <20060404200557.1e95bdd8.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604051310.55956.kernel@kolivas.org> <20060404200557.1e95bdd8.rdunlap@xenotime.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 08:05:57PM -0700, Randy.Dunlap wrote:
> On Wed, 5 Apr 2006 08:48:08 +0900 Horms wrote:
> 
> > Signed-Off-By: Horms <horms@verge.net.au
> > 
> >  machine_kexec.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Can you use diffstat -p1 ?  does git allow/support that option, so that
> more complete filenames are visible?

Sure, I have done that. I actually use a script to grab
the changelog (of my local commit), do the diffstat, and get the 
patch, as I'm not sure how to get git to do that in one pass.

> > -	 * The more common model is are caches where the behide
> > +	 * The more common model is are caches where the behind
> 
> Also delete /are/, but that sentence and the previous one still need some
> work, so fixing "behide" isn't a big deal IMO.  However, Eric can decide
> about the patch; he is the kexec maintainer.

Yeah, I puzzled over it a bit which is why I send in my original (poor) fix.
Removing the are helps a lot. Here is an updated patch which is
marginally better than my first pass.

kexec: comment fixes in machine_kexec()

 arch/i386/kernel/machine_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

720f4f4a47cf856a705b59875c099770d3b4bd5f
diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
index f73d737..d31d250 100644
--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -194,7 +194,7 @@ NORET_TYPE void machine_kexec(struct kim
 	 * set them to a specific selector, but this table is never
 	 * accessed again you set the segment to a different selector.
 	 *
-	 * The more common model is are caches where the behide
+	 * The more common model is caches where the behind
 	 * the scenes work is done, but is also dropped at arbitrary
 	 * times.
 	 *
