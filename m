Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTKSOn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTKSOn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:43:59 -0500
Received: from reptilian.maxnet.nu ([212.209.142.131]:26893 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S264106AbTKSOny convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:43:54 -0500
From: Thomas Habets <thomas@habets.pp.se>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: PATCH: forgotten EXPORT_SYMBOL()s on sparc
Date: Wed, 19 Nov 2003 15:40:15 +0100
User-Agent: KMail/1.5.4
Cc: sparclinux@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E1AMJBP-0003L5-00@reptilian.maxnet.nu> <20031119052327.GF25965@devserv.devel.redhat.com>
In-Reply-To: <20031119052327.GF25965@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311191540.24097.thomas@habets.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 19 November 2003 06:23, Pete Zaitcev wrote:
> The csum_partial is exported by kernel/ksyms.c. Why does it fail?

Not on sparc? Which file do you mean exactly? There doesn't seem to be any 
ksyms.c in the arch-independant part, nor in arch/sparc/. 2.6.0-test9

If fails when I try to modprobe some modules (ipv6, ...) with "Unknown symbol 
csum_partial" or similar. Though I am running a stripped kernel (it wouldn't 
boot otherwise, too big. And yes, I made everything that could be a module a 
module).

- ---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux 2.4" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/u4DXKGrpCq1I6FQRAsOYAKD9TImfP6/URmf3VbngdUpYwPCdsQCg7Gfj
GlEfMGZuBgI4HwrFYAXqYBw=
=dAXs
-----END PGP SIGNATURE-----

