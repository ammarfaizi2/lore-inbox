Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTLDQPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTLDQPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:15:18 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:42369 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S262694AbTLDQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:13:58 -0500
Date: Thu, 4 Dec 2003 18:14:06 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] enhanced psxface.c error handling
In-Reply-To: <1070553752.14488.4.camel@glass.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.56L0.0312041813010.8695@ahriman.bucharest.roedu.net>
References: <1070553752.14488.4.camel@glass.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

I think you missed the order on this one

@@ -142,14 +143,15 @@
        walk_state = acpi_ds_create_walk_state (obj_desc->method.owning_id,
                           NULL, NULL, NULL);
        if (!walk_state) {
- -               return_ACPI_STATUS (AE_NO_MEMORY);
+               goto acpi_psx_parse_unref;
+               status = AE_NO_MEMORY;
        }

:)

On Thu, 4 Dec 2003, Felipe Alfaro Solana wrote:

> Hi!
> 
> This patch tries to fix the situation where an error could cause
> acpi_psx_execute() to exit without releasing held references to the
> elements of param[].
> 
> Thanks!
> 

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z11QPZzOzrZY/1QRAriPAJ9tJ9A+l1VVCkvxVp5xKcl29+vnBwCguemq
B4+AFaGmaYPah7YgNObfbk4=
=6Nay
-----END PGP SIGNATURE-----
