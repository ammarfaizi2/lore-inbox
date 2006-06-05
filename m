Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751088AbWFENGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWFENGP (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWFENGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:06:15 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:15260 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751088AbWFENGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:06:13 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606051300.k55D0lXE009972@wildsau.enemy.org>
Subject: Re: UDF: buggy? libdvdread vs. udf fs driver
In-Reply-To: <200606051244.k55CilhJ009962@wildsau.enemy.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Date: Mon, 5 Jun 2006 15:00:47 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   "the X UDFFindFile" means that libdvdread did not find the file.
>   you'll probably notice that Dir.Length remains zero always, which is the
>   reason that UDFFindFile fails.

ok, at least I managed to get a Dir.Length > 0 using long or short "ad"
instead of inicb -- whatever that means. "AD" like "allocation descriptor"?
long or short ADs, or ADs in the INICB? what exactly does that mean?

so:

        mkudffs --ad=long --noefe 24M
or:     mkudffs --ad=short --noefe 24M

will get me a step further, but UDFFindFile will now fail at some other place.

kind regards,
h.rosmanith


