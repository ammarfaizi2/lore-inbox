Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269294AbUICRoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbUICRoT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269735AbUICRnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:43:14 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44490 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S269731AbUICRmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:42:10 -0400
Message-Id: <200409031741.i83HfASY017164@laptop11.inf.utfsm.cl>
To: Helge Hafting <helge.hafting@hist.no>
cc: Oliver Hunt <oliverhunt@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives 
In-Reply-To: Message from Helge Hafting <helge.hafting@hist.no> 
   of "Fri, 03 Sep 2004 10:22:55 +0200." <413829DF.8010305@hist.no> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 03 Sep 2004 13:41:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@hist.no> said:

[...]

> The only new thing needed is the ability for something to be both
> file and directory at the same time.

Then why have files and directories in the first place?

>                                       Some tools will need
> a update - usually only because they blindly assume that a directory
> isn't a file too, or that a file can't be a directory too.  Remove the
> mistaken assumption and things will work because the underlying system
> calls (chdir or open) _will_ work.

But with some weird restrictions: No moving stuff around between files, no
linking, some "files" can't be deleted (how would you handle removing the
principal stream of a file?). Some stuff you'd love to do (is, in fact, the
reason for this all) just can't be allowed (i.e., J. Random Luser setting
his own icon for system-wide emacs). So the tools/scripts/users/sysadmins
will have to be painfully aware that some of the files aren't, and some of
the directories aren't either. Major pain in the neck to use, if you look
closer.  Add extra kernel complexity. For little (if any) gain.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
