Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTJSOJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 10:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTJSOJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 10:09:50 -0400
Received: from mout1.freenet.de ([194.97.50.132]:60556 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261664AbTJSOJs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 10:09:48 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Date: Sun, 19 Oct 2003 16:09:27 +0200
User-Agent: KMail/1.5.4
References: <20031015225055.GS17986@fs.tum.de.suse.lists.linux.kernel> <p731xtapd4r.fsf@oldwotan.suse.de> <200310191556.56469.ioe-lkml@rameria.de>
In-Reply-To: <200310191556.56469.ioe-lkml@rameria.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310191609.35179.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 19 October 2003 15:56, Ingo Oeser wrote:
> Hi all,

Hi Ingo

> Simple implementation today:
>
> optimize_for_speed := CFLAGS_$1 += -O3
> optimize_for_size  := CFLAGS_$1 += -Os

I experienced many problems while using -O3,
because it may randomly inline functions, that
are not marked inline. For example -O3 made
ide-scsi on 2.4 nonworking for me.
The book "Linux Device Drivers" has a longer
explanation for _not_ using -O3 on kernels.

>
> Regards
>
> Ingo Oeser

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/kpsfoxoigfggmSgRAgKEAJ9VwoVGyaP3qIm+RT0o3Q9pAhxMYgCeMz9f
vLJH6H+xM1yXfKXaXg2IPF8=
=oQIW
-----END PGP SIGNATURE-----

