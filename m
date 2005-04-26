Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVDZJaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVDZJaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVDZJaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:30:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6095 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261430AbVDZJaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:30:05 -0400
Date: Tue, 26 Apr 2005 11:30:01 +0200
From: Martin Mares <mj@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426093001.GA2419@atrey.karlin.mff.cuni.cz>
References: <3WWGj-3nm-3@gated-at.bofh.it> <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it> <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  - mount owner should not get illegitimate access to information from
>    other users' and the super user's processes
[...]
>  3) any process running with fsuid different from the owner is denied
>     all access to the filesystem

This smells. Denying access to root doesn't make any sense. I agree
that it could help in some corner cases (like avoiding automated backup
from backing up user filesystems), but in the end it's going to be
an annoyance.

Per-user namespaces (set up by PAM) look as a very reasonable solution.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"A semicolon. Another line ends in the dance of camel." -- Kabir Ahuja
