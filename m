Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUIJRoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUIJRoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUIJRoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:44:23 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42198 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267475AbUIJRoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:44:15 -0400
Message-Id: <200409101742.i8AHgY6i005015@localhost.localdomain>
To: Helge Hafting <helge.hafting@hist.no>
cc: "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea ofwhat reiser4 wants to do with metafiles and why 
In-Reply-To: Message from Helge Hafting <helge.hafting@hist.no> 
   of "Fri, 10 Sep 2004 11:42:10 +0200." <414176F2.3030301@hist.no> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 10 Sep 2004 13:42:34 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@hist.no> said:
> Theodore Ts'o wrote:
> >On Wed, Sep 08, 2004 at 12:09:52AM +0200, Robin Rosenberg wrote:

> >>Maybe file/./attribute then. /. on a file is currently
> >>meaningless. That does not avoid the unpleasant fact that has been
> >>brought up by others (only to be ignored), that the directory syntax
> >>does not allow metadata on directories. 

> >*Not* that I am endorsing the idea of being able to access metadata
> >via a standard pathname --- I continue to believe that named streams
> >are a bad idea that will be an attractive nuisance to application
> >developers, and if we must do them, then Solaris's openat(2) API is
> >the best way to proceed --- HOWEVER, if people are insistent on being
> >able to do this via standard pathnames, and not introducing a new
> >system call, I would suggest /|/ as the separator as the third least
> >worst option.  Why?

> What's wrong with using / as the separator?  It is already
> used to separate components of pathnames.  Named streams
> are very much like files in a subdirectory.

/ is separator for directories, POSIX mandates its exact use. No, POSIX
isn't broken here, and even if it was, you have to remain compatible.

> This scheme makes for very little change to existing tools,

... while breaking fundamental assumptions by all programs in a major way,
and no sane solution for legacy applications in sight, with unknown
(probably huge) correctness and security implications...

> users may then do a "gimp somefile/icon.jpg"  for example.
> Or "ls somefile/*" to see all the named streams/forks.

Please don't rehash this one. It is fundamentally broken.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
