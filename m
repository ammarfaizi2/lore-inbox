Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTKPQEu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 11:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTKPQEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 11:04:50 -0500
Received: from ns.tasking.nl ([195.193.207.2]:47625 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S262902AbTKPQEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 11:04:48 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <1068679942.3082.131.camel@mentor.gurulabs.com>
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: Re: List of SCO files
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <4f6a.3fb79fd6.49695@altium.nl>
Date: Sun, 16 Nov 2003 16:03:34 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com> wrote:
| http://www.groklaw.net/article.php?story=2003111203544653
| 
| "I used it for comparison to file listings of different kernel versions,
| and my conclusion is that this list is either based on 2.5.68 (released
| April 20, 2003) or on 2.5.69 (released May 5, 2003). Those are the only
| two versions that contain all of the listed files." -- Groklaw reader
| "Lev"

I think they used 2.5.69. Their list includes net/bridge/br_if.c, and
patch 2.5.69 adds code containing the word "rcu", which is probably
one of the keywords they searched for. The following script generates
a list very close to SCOs list:

#!/bin/sh
# to be run in the linux-2.5.69 kernel tree
(
  find * -name '*.[ch]' |
  egrep -v '^(drivers|sound)|(arch/|include/asm-)(sparc|alpha|parisc)' |
  xargs egrep -iwl '(smp|numa|rcu)'
  ls fs/jfs/*.[ch]
) |
sort -u

The only files not on SCOs list are:

arch/um/drivers/harddog_kern.c
arch/um/drivers/harddog_user.c
arch/um/drivers/mconsole_kern.c
include/asm-h8300/smplock.h

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

