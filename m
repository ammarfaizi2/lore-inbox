Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbUKBJ2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUKBJ2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUKBJ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:28:20 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:14217 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S261868AbUKBJ17 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:27:59 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Mark Broadbent <m.broadbent@signal.QinetiQ.com>
Subject: Re: ethernet channel bonding (bonding.o) on 2.6.x
Date: Tue, 2 Nov 2004 10:32:38 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200411010955.00347.m.watts@eris.qinetiq.com> <41866D36.70908@signal.QinetiQ.com>
In-Reply-To: <41866D36.70908@signal.QinetiQ.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200411020932.38877.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.47; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


[cc: lkml for the archives]

>
> The module should support multiple bonds by loading just one module,
> however in:
>
> include/linux/if_bonding.h:81:#define BOND_DEFAULT_MAX_BONDS  1   /*
> Default maximum number of devices to support */
>
> Have you tried adding the option:
>
> max_bonds = 2
>
> the the options line?
>
> With regard to the line:
>
> options bond1 -o bonding1 miimon=100 mode=1
>
> I ran into this one a while ago as the -o option doesn't work with 2.6
> kernels in the modprobe.conf file.  I believe the theory is that modules
> should be able to support multiple devices without having to be loaded
> twice.


This works perfectly!

I'll do a patch to the documentation to reflect this.

Thanks.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBh1Q2Bn4EFUVUIO0RAjG5AKCSYDrVjLOHFcC4mycsBe9R6FtwzACcC2ki
LX/IhlscYF889fGU0U8IwYA=
=Vex7
-----END PGP SIGNATURE-----
