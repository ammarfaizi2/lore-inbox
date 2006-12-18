Return-Path: <linux-kernel-owner+w=401wt.eu-S1754379AbWLRSfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbWLRSfc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbWLRSfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:35:31 -0500
Received: from smtp7.tech.numericable.fr ([82.216.111.43]:52406 "EHLO
	smtp7.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbWLRSfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:35:31 -0500
Date: Mon, 18 Dec 2006 19:35:26 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.20-rc1-mm1
Message-ID: <20061218183526.GA14297@localhost.localdomain>
References: <20061214225913.3338f677.akpm@osdl.org> <20061215203936.GA2202@localhost.localdomain> <20061215130141.fd6a0c25.akpm@osdl.org> <20061217110710.GA1994@localhost.localdomain> <45864B68.2030306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45864B68.2030306@free.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The reiser4 failure is unexpected. Could you please see if you can
> > > capture a trace, let the people at reiserfs-dev@namesys.com know?

> > Ok, I've handwritten the messages, here they are :

> > reiser4 panicked cowardly : reiser4[umount(2451)] : commit_current_atom 
> > (fs/reiser4/txmngr.c:1087) (zam-597)
> > write log failed (-5)

> > [ got 2 copies of them because I have 2 reiser4 fs)

> > I got them mainly when I try to reboot or halt the machine, and the
> > process doesn't finish, the computer gets stuck after the reiser4
> > messages. This is only with 2.6.20-mm1, not 2.6.19-rc6-mm2.

* Laurent Riffard <laurent.riffard@free.fr> [2006-12-18 09:03]:
> fix-sense-key-medium-error-processing-and-retry.patch seems to be the
> culprit.

> Reverting it fix those reiser4 panics for me. Damien, could you confirm 
> please ?

Yes, this fixes it too on my side. Thanks for this tracking !

-- 
Damien Wyart
