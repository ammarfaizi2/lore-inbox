Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTDWOub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbTDWOub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:50:31 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:18654 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264061AbTDWOua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:50:30 -0400
Date: Wed, 23 Apr 2003 10:48:58 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423144857.GN354@phunnypharm.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423145122.GL820@hottah.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As for 2.4.21, well, we want something pretty well tested. Will this
> be the case with your new mega-patch ? I don't think so. The safest
> is to go back to a version which worked. At least the bugs of that
> version are known, which is not the case for the new version.

BTW, have you even tested the patch? I can almost guarantee is is more
stable than what was in -pre7 (outside of the one small fix I had to
apply for the IRM looping). The -pre7 code has loads of irq disabling
problems and dead lock issues, not to mention the race conditions.

The problem you see with the irq disabling around kernel_thread() may
not be there in -pre7, but that's only because the shared data with the
thread was not protected from a race condition that causes an oops in
some not-so-rare cases.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
