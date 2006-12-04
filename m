Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936966AbWLDP0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936966AbWLDP0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936982AbWLDP0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:26:08 -0500
Received: from smtp-01.mandic.com.br ([200.225.81.132]:36526 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936966AbWLDP0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:26:05 -0500
Message-ID: <45743E0C.6090705@mandic.com.br>
Date: Mon, 04 Dec 2006 13:26:04 -0200
From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: kvm-devel@lists.sourceforge.net, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, renatoyamane@mandic.com.br
Subject: Re: [PATCH] KVM: mmu: honor global bit on huge pages
References: <20061204145735.89391A0016@il.qumranet.com>
In-Reply-To: <20061204145735.89391A0016@il.qumranet.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=D420515A;
	url=http://pgp.mit.edu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mandic-no-Celular-to: renatoyamane@mandic.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Em 04-12-2006 12:57, Avi Kivity escreveu:
> The kvm mmu attempts to cache global translations, however it misses on
> global huge page translation (which is what most global pages are).
> 
> By caching global huge page translations, boot time of fc5 i386 on i386
> is reduced from ~35 seconds to ~24 seconds.

I try use this patch in Kernel 2.6.19-git5, but I receive an error message:

/linux-2.6.19# patch -p1 < /home/yamane/Desktop/kernel/kvm.patch
can't find file to patch at input line 3
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
- --------------------------
|--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
|+++ linux-2.6/drivers/kvm/paging_tmpl.h
- --------------------------
File to patch:

Whats wrong? :-(

Best regards,
- --
Renato S. Yamane
Fingerprint: 68AE A381 938A F4B9 8A23  D11A E351 5030 D420 515A
PGP Server: http://pgp.mit.edu/ --> KeyID: 0xD420515A
<http://www.renatoyamane.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFdD4M41FQMNQgUVoRAqLLAJ0QY0x67w7TrYFqJqgCZ3XT3i35IgCeNfvy
+YYKNzrY46tvbM+nf9u1lc4=
=gkQV
-----END PGP SIGNATURE-----
