Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269472AbUIZBdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269472AbUIZBdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269473AbUIZBdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:33:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64444 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269472AbUIZBdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:33:06 -0400
Date: Sun, 26 Sep 2004 02:33:00 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] make make install install modules too
Message-ID: <20040926013300.GL16153@parcelfarce.linux.theplanet.co.uk>
References: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk> <200409171338.51924.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171338.51924.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 01:38:51PM -0400, Gene Heskett wrote:
> This is not a good patch IMO.  Many of us do things with scripts to 
> drive the compile process, either in the name of repeatability or 
> consistency.   These scripts may step out of the src tree and go make 
> something else (lm_sensors comes to mind when it wasn't part of the 
> kernel) whose output goes into the /lib/modules/version/ directory so 
> that by the time the make modules_install runs, everything is already 
> in place for the automatic depmod the modules_install does.  We 
> *could* work around it by re-adding the depmod lines to our scripts, 
> but it seems that might be called a kludge too.

Documentation/kbuild/modules.txt answers how to do this "right".  In any
case, there's nothing to stop you changing your scripts from
"make install && do_my_special_thing && make modules_install"
to
"make kernel_install && do_my_special_thing && make modules_install"

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
