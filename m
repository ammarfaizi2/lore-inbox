Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUDHT3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUDHT3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:29:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:25753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262266AbUDHT3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:29:35 -0400
Date: Thu, 8 Apr 2004 12:29:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Nick.Holloway@pyrites.org.uk
Subject: Re: [PATCH 2.6] Add missing MODULE_PARAM to dummy.c (and MAINTAINERShip)
Message-ID: <20040408122930.S21045@build.pdx.osdl.net>
References: <20040408174823.GA13335@localhost> <20040408105440.G22989@build.pdx.osdl.net> <20040408185903.GA21236@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040408185903.GA21236@localhost>; from linux-kernel@24x7linux.com on Thu, Apr 08, 2004 at 08:59:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jose Luis Domingo Lopez (linux-kernel@24x7linux.com) wrote:
> On Thursday, 08 April 2004, at 10:54:40 -0700,
> Chris Wright wrote:
> 
> > this is going backwards.  module_param is the newer (preferred) interface.
> > 
> I (incorrectly) based my assumptions on the fact that "modinfo dummy"
> didn't return any information about the module parameter. I also had a
> look at some other modules, like "bonding", "rtl8139", and I assumed
> that the MODULE_* macros were the 2.6.x way of doing things.

It's a mix.  module_param(), MODULE_PARM_DESC(), MODULE_LICENSE(),
MODULE_AUTHOR(), MODULE_DESCRIPTION().

So the whole patch isn't bad, just the bit like:
-module_param()
+MODULE_PARM()

> I was obviously wrong, sorry for the waste of time (anyways, it seems
> there are several kernel modules waiting to be updated, maybe I should
> give them a look and learn something and try to "fix" them).

Sure, although some of these changes may not be accepted simply because
they create noise, patch conflicts etc at a time where stability is more
important.  So new code should use the new ones, old code may not all be
converted for some time.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
