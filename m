Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTDVIck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbTDVIck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:32:40 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:48300 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263020AbTDVIce
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 22 Apr 2003 04:32:34 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16037.245.828642.171327@laputa.namesys.com>
Date: Tue, 22 Apr 2003 12:44:37 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrew Morton <akpm@digeo.com>
Cc: Linux-Kernel@Vger.Kernel.ORG, Torvalds@Transmeta.COM
Subject: Re: [PATCH] (one line): use #ifdef with CONFIG_*
In-Reply-To: <20030422013519.23754c14.akpm@digeo.com>
References: <16036.64756.25228.181408@laputa.namesys.com>
	<20030422013519.23754c14.akpm@digeo.com>
X-Mailer: VM 7.07 under 21.5  (beta11) "cabbage" XEmacs Lucid
X-Zippy-Says: Psychoanalysis??  I thought this was a nude rap session!!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > > -#if CONFIG_DEBUG_HIGHMEM
 > > +#ifdef CONFIG_DEBUG_HIGHMEM
 > 
 > mnm:/usr/src/linux-2.5.68> grep -r '#if[        ]*CONFIG' . | wc -l
 >     185
 > 
 > Why fix this one in particular?

Err, I just added -Wundef to cc options and it was the only one that has
shown up. Probably all of them should be corrected at once.

Nikita.
