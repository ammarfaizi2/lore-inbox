Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVCPCut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVCPCut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 21:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVCPCut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 21:50:49 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:1481 "HELO
	develer.com") by vger.kernel.org with SMTP id S262476AbVCPCuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 21:50:37 -0500
Message-ID: <42379ECC.9060100@develer.com>
Date: Wed, 16 Mar 2005 03:49:48 +0100
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0-5 (X11/20050308)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Conway <nconway_kernel@yahoo.co.uk>
CC: Anders Saaby <as@cohaesio.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: Re: NFS client bug in 2.6.8-2.6.11
References: <20050315234415.71730.qmail@web26510.mail.ukl.yahoo.com>
In-Reply-To: <20050315234415.71730.qmail@web26510.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Conway wrote:

> 766 -> 770 sounds like a "small" (ish) number of patches to check, if
> we're lucky.  Did you wade through 'em all yet?  Any smoking guns?

The RPM changelog doesn't contain anything relevant
between 766 and 770:

---CUT---
* Thu Feb 24 2005 Dave Jones <davej@redhat.com>

- Use old scheme first when probing USB. (#145273)

* Wed Feb 23 2005 Dave Jones <davej@redhat.com>

- Try as you may, there's no escape from crap SCSI hardware. (#149402)

* Mon Feb 21 2005 Dave Jones <davej@redhat.com>

- Disable some experimental USB EHCI features.

* Tue Feb 15 2005 Dave Jones <davej@redhat.com>

- Fix bio leak in md layer.
---CUT---

Perhaps the changelog is incomplete.  I don't have the
two SRPMs at hand to make a comparison.

By the way, it seems upgrading to 2.6.10-1.770_FC3 just made
the bug much harder to trigger: I've definitely seen it once
again when I had left a shell sitting in an NFS directory
overnight.  I couldn't reproduce it a second time.


> PS: oh bugger, just remembered that I also reproduced my bug with a
> 2.6.8 kernel on the server; admittedly though it was an FC2 kernel so
> who knows what extra patches it had.

You can easily find out by downloading the SRPM.  Now that
Fedora provides a public CVS, perhaps it could be used to
make such investigations directly with the cvsweb interface
without downloading and unpacking a 40MB file.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

