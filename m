Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135521AbRDSCrr>; Wed, 18 Apr 2001 22:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135526AbRDSCrh>; Wed, 18 Apr 2001 22:47:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:35343 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135521AbRDSCrT>;
	Wed, 18 Apr 2001 22:47:19 -0400
Date: Wed, 18 Apr 2001 23:45:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Phillips <phillips@nl.linux.org>
Cc: linux-kernel@vger.kernel.org, adilger@turbolinux.com,
        ext2-devel@lists.sourceforge.net
Subject: Re: Ext2 Directory Index - Delete Performance
In-Reply-To: <20010419002757Z92249-1659+3@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0104182343240.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Daniel Phillips wrote:

> OK, now I know what's happening, the next question is, what should be
> dones about it.  If anything.

[ discovered by alexey on #kernelnewbies ]

One thing we should do is make sure the buffer cache code sets
the referenced bit on pages, so we don't recycle buffer cache
pages early.

This should leave more space for the buffercache and lead to us
reclaiming the (now unused) space in the dentry cache instead...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

