Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTKJWNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbTKJWNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:13:42 -0500
Received: from web11904.mail.yahoo.com ([216.136.172.188]:19719 "HELO
	web11904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263203AbTKJWNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:13:41 -0500
Message-ID: <20031110221340.76741.qmail@web11904.mail.yahoo.com>
Date: Mon, 10 Nov 2003 14:13:40 -0800 (PST)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: [Dri-devel] Problems with the radeon 1.9.0 driver in 2.6.0-test9-mm2
To: "lists.sourceforge.net dri-devel" <dri-devel@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1068466480.9513.27.camel@thor.asgaard.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Michel Dänzer <michel@daenzer.net> wrote:
> On Fri, 2003-11-07 at 23:05, Andrew Morton wrote: 
> > 
> > Has anyone actually tested the functionality which this patch is supposed
> > to provide?  That loading the DRM module magically triggers a load of AGP? 
> 
> Haven't tried it, but I doubt it does looking at the code for symbol_get
> and friends... try_then_request_module() might do the trick instead?
> 
> Either way, it won't help the fact that loading agpgart is no longer
> enough, the chipset specific AGP module needs to be loaded.
> 
This is what aliases are for :)
I think modprobe can be made to handel everything, if modules advertise what aliases thay provide.
 Depmod can list aliases depending on device IDs depending on the real module in it's database,
then when modprobe is assked to load (an alias) it can make a match and load the right mod(s if
there is more than one).  It would brakdown like this.  There would be several mods with the same
name, modprobe would try to satisfy the dependencys of each one, failing if the device IDs are not
present.

indicate on your message that you wish to be personally CC'ed the answers/comments posted to the
list in response to your posting.

> > Or is it the other way around?
> 
> Only really makes sense this way around. :)
> 
How about we put the AGP module name in the XF86Config and have X load everything.  I personaly
HATE this idea, IMHO X(and other programs for that matter) should not alter loaded modules nor
should it alter device nodes exept to change the owner like login dose for ttys.


__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
