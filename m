Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTEROMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTEROMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:12:16 -0400
Received: from mailsrv.rollanet.org ([192.55.114.7]:49332 "HELO
	mx.rollanet.org") by vger.kernel.org with SMTP id S262069AbTEROMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:12:14 -0400
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG
	support
From: Nathan Neulinger <nneul@umr.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
In-Reply-To: <20030517123044.GG686@zaurus.ucw.cz>
References: <8812.1052841957@warthog.warthog>
	 <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com>
	 <20030513172029.GB25295@delft.aura.cs.cmu.edu>
	 <20030517123044.GG686@zaurus.ucw.cz>
Content-Type: text/plain
Organization: University of Missouri - Rolla
Message-Id: <1053267749.23613.14.camel@nneul-laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 May 2003 09:22:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ? If he has same uid as you *and* you
> have >=1 process running, what prevents
> him from gdb attach <that process>,
> and force it to do whatever he needs
> by forcing syscall?
> 				Pavel

That's a good point, and perhaps it should be an option to not allow
ptrace or other potentially dangerous operations between processes in
different pags. But leave that optional, as it might still be useful -
for example, logging in and diagnosing a daemon running in a separate
pag.

It's not clear if this would be best as a per-pag flag or a global one
though. 

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216

