Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVJFTPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVJFTPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVJFTPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:15:49 -0400
Received: from free.hands.com ([83.142.228.128]:14547 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1751313AbVJFTPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:15:48 -0400
Date: Thu, 6 Oct 2005 20:15:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Diego Calleja <diegocg@gmail.com>
Cc: chase.venters@clientec.com, marc@perkel.com, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051006191522.GS10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net> <20051005130410.ddae71b3.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005130410.ddae71b3.diegocg@gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 01:04:10PM +0200, Diego Calleja wrote:

> El Wed, 5 Oct 2005 11:26:50 +0100,
> Luke Kenneth Casson Leighton <lkcl@lkcl.net> escribi?:
> 
> > > Now I certainly wouldn't advocate a Windows-style registry, 
> > > because I think it's full of obvious problems. 
> > 
> >  such as? :)
> 
> 
> The ugly implementation (inside the kernel and as a big file instead of doing it as a

 the nt 3.51 implementation got it right: userspace service (MSRPC
 service) with LPC (this is NT, based on Mach, so they have LPC which is
 message-passing - joy) communicating from userspace to kernelspace
 where necessary.

 nooo, it not okay to have registry in kernel.  _access_ to it (via
 ioctl's) yes.  _in_ kernel, friggin'ell'no.

 regarding the other points: yes, there's a per-user hive key, which is
 "overlaid" onto parts of the sub-tree.

 and yes, the previous poster is absolutely right: the benefits cannot
 be felt unless evvverrryyy service under the sun is also using it.

 ... but heck - we do configuration of pretty much every major service
 under the sun out of ldap, don't we?
 
 and openldap itself just got the ability to read its own
 config out of its own database, right?

 it's not _that_ far off, not _that_ unachievable, s/ldap/registry.

 there's just a few core services missing - initscripts is a good
 example - which nobody's yet had the nerve to tackle (afaik) and dump
 into LDAP.

 in that example, mostly because there's not much point unless
 you're also going to do something decent like put in proper
 dependencies (see depinit).

 anyway.  how on _earth_ did we get here, and please could
 someone advise me - and everyone else - of a more suitable
 location to discuss these matters?

 l.

