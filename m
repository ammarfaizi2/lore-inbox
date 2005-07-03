Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVGCRVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVGCRVu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGCRVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 13:21:50 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:2719 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261474AbVGCRVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 13:21:03 -0400
Date: Sun, 3 Jul 2005 18:52:06 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] IDE update
Message-ID: <Pine.GSO.4.62.0507031847460.678@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please pull from:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git

diffstat+changelog below

Bartlomiej


  drivers/ide/Makefile        |    1 -
  drivers/ide/ide-lib.c       |   13 +++++--------
  drivers/ide/pci/alim15x3.c  |   10 +++++-----
  drivers/ide/pci/amd74xx.c   |    7 +++++--
  drivers/ide/pci/cs5530.c    |    4 ++--
  drivers/ide/pci/cy82c693.c  |    8 ++++----
  drivers/ide/pci/it8172.c    |    4 ++--
  drivers/ide/pci/ns87415.c   |    2 +-
  drivers/ide/pci/opti621.c   |    2 +-
  drivers/ide/pci/sc1200.c    |    2 +-
  drivers/ide/pci/sl82c105.c  |    6 +++---
  drivers/ide/pci/slc90e66.c  |    2 +-
  drivers/ide/pci/triflex.c   |    2 +-
  drivers/ide/pci/via82cxxx.c |    4 ++--
  include/linux/pci_ids.h     |    1 +
  15 files changed, 34 insertions(+), 34 deletions(-)

commit 10e047b40aafefef1fdc8ea4ea7837b9557a9400
tree 4105ba774c775cdf53fb5fd3e07158b15218cb27
parent 21e2c01dc3e38d466eda5871645878d2c3a33261
author Adrian Bunk <bunk@stusta.de> Sun, 03 Jul 2005 17:44:10 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 17:44:10 +0200

[PATCH] drivers/ide/Makefile: kill dead CONFIG_BLK_DEV_IDE_TCQ entry

This patch kills the dead CONFIG_BLK_DEV_IDE_TCQ entry.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 21e2c01dc3e38d466eda5871645878d2c3a33261
tree a2a4fb15b2295e635de9f734f720f783c97a6513
parent 13bbbf28fb914da6707aad44a073651f5c9d13a5
author Rob Punkunus <rpunkunus@nvidia.com> Sun, 03 Jul 2005 17:37:18 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 17:37:18 +0200

[PATCH] amd74xx: support MCP55 device IDs

From: Rob Punkunus <rpunkunus@nvidia.com>

Rob Punkunus recently submitted a patch to enable support for MCP51/MCP55 in
the amd74xx driver. This patch was whitespace-corrupted and didn't apply to
2.6.12 since MCP51 support was merged in the 2.6.12-rc series.

Gentoo would like to support this hardware for our upcoming release media, so
I fixed the patch, and here it is :)

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 13bbbf28fb914da6707aad44a073651f5c9d13a5
tree 16cea5674a7da7aa1b318685598a87d7dc806ba1
parent f3718d3e135117f80de0ff219be91544baa75599
author Denis Vlasenko <vda@ilport.com.ua> Sun, 03 Jul 2005 17:09:13 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 17:09:13 +0200

[PATCH] ide: fix line break in ide messages

From: Denis Vlasenko <vda@ilport.com.ua>

* printk("\n") is misplaced, resulting in stray empty line in kernel log
* cleanups nerby: some back-to-back printks are combined, etc

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit f3718d3e135117f80de0ff219be91544baa75599
tree 48c98f74b12e7669b787bd9c75edf8fd20e07912
parent d6904ab66f74cb99793e3919fc589dd0163a7740
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:42:18 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:42:18 +0200

[PATCH] ide: hotplug mark __devinit via82cxxx.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit d6904ab66f74cb99793e3919fc589dd0163a7740
tree f68e6b3b5603d67b92a3276b35c623054c3ecdf9
parent 97319630b21c2022a55d51a6cfbf53cbb84a2f42
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:40:31 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:40:31 +0200

[PATCH] ide: hotplug mark __devinit triflex.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 97319630b21c2022a55d51a6cfbf53cbb84a2f42
tree 5d831d1f2a2c264e1d3dc55f6f2f967b7c7c010c
parent 34a6224691e638dd36b393aa439d021a19578fcc
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:38:51 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:38:51 +0200

[PATCH] ide: hotplug mark __devinit slc90e66.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 34a6224691e638dd36b393aa439d021a19578fcc
tree 0c6fb291d2d9657f83c7bb0427eacad8f6f05d81
parent 6a6e1b1cf41b0bf35fffbf18787e8d8f865b66d6
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:36:56 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:36:56 +0200

[PATCH] ide: hotplug mark __devinit sl82c105.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 6a6e1b1cf41b0bf35fffbf18787e8d8f865b66d6
tree ead647e67974ce09bf14b194be6ad99787a0c176
parent 9307145700e869dd410d565477f98377e93e9160
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:35:07 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:35:07 +0200

[PATCH] ide: hotplug mark __devinit sc1200.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 9307145700e869dd410d565477f98377e93e9160
tree bb887910e3dcef3b084a078004548268786d8166
parent c20530ed26e5b9e3b188b4088d0a5ab1d773a529
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:33:16 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:33:16 +0200

[PATCH] ide: hotplug mark __devinit opti621.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit c20530ed26e5b9e3b188b4088d0a5ab1d773a529
tree 5c68ff26c3c1fe342cc095a1a53b2d1aedada684
parent a380a8849f90ba81a5ff0c325fd5d8125c70b3bb
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:31:04 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:31:04 +0200

[PATCH] ide: hotplug mark __devinit ns87415.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit a380a8849f90ba81a5ff0c325fd5d8125c70b3bb
tree 5c0ee15020ff929536331d9a00a76cbfac0bf035
parent ddbc9fb47252f9b6966bfe9b0aa27bfeaa585cca
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:28:44 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:28:44 +0200

[PATCH] ide: hotplug mark __devinit it8172.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit ddbc9fb47252f9b6966bfe9b0aa27bfeaa585cca
tree 41eefbf36f12c095303eb0811c8e28ea6af895db
parent 88de8e996f16b958721368ed9b4fd4e29cdb923e
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:25:46 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:25:46 +0200

[PATCH] ide: hotplug mark __devinit cy82c693.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 88de8e996f16b958721368ed9b4fd4e29cdb923e
tree 24f89d1a1f739a4c48376e11b8a73c1f46a71ccb
parent e895f926cd8b6d50a42cc985d470bdc9a70caeed
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:23:08 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:23:08 +0200

[PATCH] ide: hotplug mark __devinit cs5530.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit e895f926cd8b6d50a42cc985d470bdc9a70caeed
tree 8c2bc70f185842dfcd795f06afdb33d65e193d51
parent c2f12589bfc4119f2c331ecea8cca4945ed48497
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:15:41 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:15:41 +0200

[PATCH] ide: hotplug mark __devinit amd74xx.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit c2f12589bfc4119f2c331ecea8cca4945ed48497
tree d00d17e062b845f35c79b456a70e8d3b45b3b556
parent 1d6bebf2ecf92924492c491d9c3a72edba95f907
author Herbert Xu <herbert@gondor.apana.org.au> Sun, 03 Jul 2005 16:06:13 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Sun, 03 Jul 2005 16:06:13 +0200

[PATCH] ide: hotplug mark __devinit alim15x3.c

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

see the thread about the pci hotplug crash on a stratus box.
http://marc.theaimsgroup.com/?l=linux-kernel&m=111930108613386&w=2

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
