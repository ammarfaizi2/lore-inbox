Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285944AbRLTD0n>; Wed, 19 Dec 2001 22:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285959AbRLTD0h>; Wed, 19 Dec 2001 22:26:37 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:64004 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285944AbRLTD0U>;
	Wed, 19 Dec 2001 22:26:20 -0500
Date: Thu, 20 Dec 2001 01:23:39 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: SteveW@ACM.org, jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
        dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC 3] cleaning up struct sock
Message-ID: <20011220012339.A919@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, SteveW@ACM.org,
	jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
	dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011218033552.B910@conectiva.com.br> <20011217.225134.91313099.davem@redhat.com> <20011218185200.A1211@conectiva.com.br> <20011218.130809.22018359.davem@redhat.com> <20011218232222.A1963@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011218232222.A1963@conectiva.com.br>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, patch for 2.5.1, without the bogus cvs $id strings hunks, being used
in this machine now.

Available at:

http://www.kernel.org/pub/linux/kernel/people/acme/v2.5/2.5.1/
sock.cleanup-2.5.1.patch.bz2

Ah, the lat_unix_connect results on a pentium 300 mmx notebook:

2.5.1 + this patch
UNIX connection cost : 96.1749 microseconds
UNIX connection cost : 96.3361 microseconds
UNIX connection cost : 97.2310 microseconds
UNIX connection cost : 101.9180 microseconds
UNIX connection cost : 97.2461 microseconds

2.4.16 pristine
UNIX connection cost : 112.7034 microseconds
UNIX connection cost : 114.5494 microseconds
UNIX connection cost : 114.0923 microseconds
UNIX connection cost : 111.0959 microseconds
UNIX connection cost : 120.8419 microseconds

And about 100 KB of kernel memory saved for AF_UNIX sockets on a basic KDE
session (i.e., the AF_UNIX struct sock now is about 400 bytes when it is about
1200 bytes on a pristine kernel).

- Arnaldo
