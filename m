Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVJEK1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVJEK1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVJEK1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:27:18 -0400
Received: from free.hands.com ([83.142.228.128]:10404 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932544AbVJEK1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:27:17 -0400
Date: Wed, 5 Oct 2005 11:26:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chase Venters <chase.venters@clientec.com>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005102650.GO10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510041840.55820.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510041840.55820.chase.venters@clientec.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 06:40:33PM -0500, Chase Venters wrote:

> Work on dbus and HAL should give us good improvements in these areas. One 

 dbus.  total waste of several man-years of effort that could have been
 better spent in e.g. removing the dependency of posix draft 4 threads
 from freedce (which i finally did last month) and e.g. adding an ultra-fast
 shared-memory transport plugin.

 hal.  _excellent_.  look forward to it being ported to win32 so that
 it's useful for the kde-win32 port etc. etc.

> remaining challenge I see is system configuration - each daemon tends to 
> adopt its own syntax for configuration, which means that providing a GUI for 
> novice users to manage these systems means attacking each problem separately 
> and in full. 

 that's quite straightforward to deal with but it _does_ mean using a
 unified approach to writing APIs.

 NT solved this problem by writing graphical tools in c and then
 adopting dce/rpc as the means to administer the services both locally
 _and_ remotely.

 wholesale.  utterly.  everything.  right from the simplest things like
 rebooting the machine, through checking the MAC addresses of cards
 (NetTransportEnum) all the way up to DNS administration - yes,
 dnsadmin.exe will write out DNS zone files in proper bind format.

 it's quite a brave choice to take.

> Now I certainly wouldn't advocate a Windows-style registry, 
> because I think it's full of obvious problems. 

 such as? :)

 they're not obvious to me.  at the risk of in-for-penny, in-for-pound
 _radically_ off-topic discussion encouragement here, and also for
 completeness should someone come back to the archives in some years or
 months and go "what obvious problems", could you kindly elaborate?

 one i can think of is "eek, my system's broken, eek, i can't even use
 vi to edit the configs".

 and having described the problem, then.. .. well... actually...
 it's simply dealt with:

 http://www.bindview.com/Services/RAZOR/Utilities/Unix_Linux/ntreg_readme.cfm

 todd sabin wrote a linux filesystem driver which is read-only, so at
 least half the work's done.

 (and the reactos people have written a complete implementation
 of a registry, btw).

> Nevertheless, it would be nice 
> to have some kind of configuration editor abstraction library that had some 
> sort of syntax definition database to allow for some interesting work on 
> GUIs.
 
 i have to say this: it's almost too radical, dude :)

 he he.


> In any case, I think pretty much all of this work lives outside the kernel. 

 ACK!

 ... well... not entirely.

 a "registry" - god help us - would need to be stored on a filesystem.
 and then, ideally, made accessible a la todd sabin's ntreg driver - via
 a POSIX interface (because the linux kernel doesn't _do_ anything other
 than POSIX filesystems *sigh*).  and that makes it also convenient to
 access from kernelspace, too.

 hey, you know what?  if linux got a registry, it would be possible for
 the kernel to access - and store, and communicate - persistent
 information.

 conveniently.

 hurrah.

 
