Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVIGLpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVIGLpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVIGLpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:45:08 -0400
Received: from ns.firmix.at ([62.141.48.66]:38112 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932120AbVIGLpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:45:07 -0400
Subject: Re: kbuild & C++
From: Bernd Petrovitsch <bernd@firmix.at>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Valdis.Kletnieks@vt.edu, Jesper Juhl <jesper.juhl@gmail.com>,
       "Budde, Marco" <budde@telos.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10509071055180.21532-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10509071055180.21532-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 07 Sep 2005 13:44:53 +0200
Message-Id: <1126093493.24425.62.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 11:21 +0200, Esben Nielsen wrote:
> On Tue, 6 Sep 2005 Valdis.Kletnieks@vt.edu wrote:
> 
> > On Wed, 07 Sep 2005 00:20:11 +0200, Esben Nielsen said:
> > 
> > > Which is too bad. You can do stuff much more elegant, effectively and
> > > safer in C++ than in C. Yes, you can do inheritance in C, but it leaves
> > > it up to the user to make sure the type-casts are done OK every time. You
> > > can with macros do some dynamic typing, but not nearly as effectively as
> > > with templates, and those macros always comes very, very ugly. (Some say
> > > templates are ugly, but they first become ugly when they are used
> > > way beyond what you can do with macros.)
> > > 
> > > I think it can only be a plus to Linux to add C++ support for at least
> > > out-of-mainline drivers. Adding drivers written in C++ into the mainline
> > > is another thing.
> > 
> > http://www.tux.org/lkml/#s15-3 Why don't we rewrite the Linux kernel in C++?
> 
> I can't see it should be _that_ hard to make the kernel C++ friendly. At work 
> I use a RTOS written in plain C but where you can easily use C++ in kernel
> space (there is no user-space :-). We use gcc by the way.

Of course. Probably the easiest way is
-) to provide a pure C interface (read: write functions with C linkage
   that call your C++ stuff) to your C++ stuff
-) compile your C++ sources separately
-) kill all not-existing features needed by the linker and other
   programs (or implement them in the kernel/your module).

> PS. Do the above people break GPL by forcing people to accept a
> license-agreement before downloading a patch to the kernel? Shouldn't they
> provide a direct url?

As long as the license agreement does not conflict with the GPL, I can't
see a legal problem. And you can download their source - which is
probably GPL - and put it online wherever you want.
It is inpolite though, IMHO. But it is also inpolite to top-post, break
threads, include meaningless disclaimers, etc.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

