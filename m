Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276532AbRJVP4V>; Mon, 22 Oct 2001 11:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276917AbRJVP4L>; Mon, 22 Oct 2001 11:56:11 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:55082 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276532AbRJVPz5>; Mon, 22 Oct 2001 11:55:57 -0400
Date: Mon, 22 Oct 2001 11:56:32 -0400
Message-Id: <200110221556.f9MFuWH15850@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
X-Newsgroups: linux.dev.kernel
In-Reply-To: <24947.1003742395@ocs3.intra.ocs.com.au>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <24947.1003742395@ocs3.intra.ocs.com.au> kaos@ocs.com.au wrote:

| Historically the mapping of device majors to module or binary format
| type to module was coded into modutils, via util/alias.h.  That was a
| mistake, it should have used the same technique as pci, isapnp, parport
| etc., each module has a table that defines what it handles and modutils
| extracts the data directly from the modules.  Developers have changed
| the names of their modules and now we have hard coded module names in
| modutils that do not match the names used by some kernels.  Hindsight
| is wonderful!

  Not to mention the recent surge of renaming the parameters of modules
for no obvious reason... The number of conditionals in modules.conf is
getting pretty large for people who need to run multiple kernels until
the release of one which fixes all the bugs.

| In modutils 2.5 I will get rid of all the hard coded entries in
| util/alias.h.  Instead each module will define what it supports,
| including any special commands to be run when the module is loaded or
| unloaded.  Much easier for everyone and far more flexible.

  I'm not sure about flexible, does it matter where the parameters or
commands are built-in as long as the admin has to change source code
instead of config files to change it? It just seems like a really poor
approach to what has been very flexible.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
