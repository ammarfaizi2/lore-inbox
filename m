Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281917AbRKUSmt>; Wed, 21 Nov 2001 13:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281932AbRKUSmi>; Wed, 21 Nov 2001 13:42:38 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.27]:6423 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S281451AbRKUSmb>; Wed, 21 Nov 2001 13:42:31 -0500
Date: Wed, 21 Nov 2001 19:42:23 +0100
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: linux-kernel@vger.kernel.org
Cc: linux-hams <linux-hams@vger.kernel.org>, tomi.manninen@hut.fi,
        dg2fef@afthd.tu-darmstadt.de
Subject: Re: [PATCH] Using sock_orphan in ax25 and netrom
Message-ID: <20011121194223.A1187@jeroen.pe1rxq.ampr.org>
In-Reply-To: <20011120154610.A189@jeroen.pe1rxq.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011120154610.A189@jeroen.pe1rxq.ampr.org>; from pe1rxq@amsat.org on Tue, Nov 20, 2001 at 15:46:10 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appearantly my patch from yesterday was a bit premature...

It looks like the ax25 and netrom stack do some magic with the dead sockets
that is not compatible with sock_orphan. I will try and see if I can track
them down.

The result is that at the moment the only way to make ax25 stable in 2.4.x
is to add the sk->dead check in my first patch.

Jeroen


