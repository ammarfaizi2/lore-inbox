Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267363AbTACAwk>; Thu, 2 Jan 2003 19:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTACAwk>; Thu, 2 Jan 2003 19:52:40 -0500
Received: from bitmover.com ([192.132.92.2]:48549 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267363AbTACAwj>;
	Thu, 2 Jan 2003 19:52:39 -0500
Date: Thu, 2 Jan 2003 17:01:07 -0800
From: Larry McVoy <lm@bitmover.com>
To: Thomas Ogrisegg <tom@rhadamanthys.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       lm@bitmover.com
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
Message-ID: <20030103010107.GB6416@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Thomas Ogrisegg <tom@rhadamanthys.org>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	lm@bitmover.com
References: <20021230012937.GC5156@work.bitmover.com> <1041489421.3703.6.camel@rth.ninka.net> <20030102221210.GA7704@window.dhis.org> <20030102.151346.113640740.davem@redhat.com> <20030103004543.GA12399@window.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103004543.GA12399@window.dhis.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It might be a bit difficult to convert all applications to
> sendfile. Especially those for which you don't have the
> source code.

And the list of applications which do

	sock = socket(...);
	map = mmap(...);
	write(sock, map, bytes);

are?  There are not very many that I know of and if you look carefully
at the bandwidth graphs in LMbench you'll see why.  There is a cross
over point where mmap becomes cheaper but it used to be around 16-64K.
I don't know what it is now, I doubt it's moved much.  I can check if
you really want.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
