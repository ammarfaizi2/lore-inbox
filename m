Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTEIWKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbTEIWKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:10:32 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:39572
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263547AbTEIWK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:10:29 -0400
Message-ID: <3EBC2A3C.8040409@redhat.com>
Date: Fri, 09 May 2003 15:22:52 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC29A5.1050005@techsource.com>
In-Reply-To: <3EBC29A5.1050005@techsource.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Timothy Miller wrote:

> If your program is capable of handling an address with more than 32
> bits, what point is there giving a hint?  Either your program can handle
> 64-bit pointers or it cannot.  Any program flexible enough to handle
> either size dynamically would expend enough overhead checking that it
> would be worse than if it just made a hard choice.

Look at the x86-64 context switching code.  If memory addressed by the
GDT entries has a 32-bit address it uses a different method than for
cases where the virtual address has more than 32 bits.  This way of
handling GDT entries is faster according to ak.  So, it's not a
correctness thing, it's a performance thing.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vCo82ijCOnn/RHQRAlGzAJ9Ti80kJMeecyxGikowWcfCAq0stwCfRVcQ
Clui3Z6yKNSy3mu+phrY2FQ=
=GFwi
-----END PGP SIGNATURE-----

