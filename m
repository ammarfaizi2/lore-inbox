Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbULITdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbULITdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbULITdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:33:14 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:41959 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261583AbULITdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:33:00 -0500
Date: Thu, 9 Dec 2004 11:32:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
In-Reply-To: <156610000.1102546207@flay>
Message-ID: <Pine.LNX.4.58.0412091130160.796@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain><Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com><Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org><Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com><Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org><Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com><Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
 <41AEB44D.2040805@pobox.com><20041201223441.3820fbc0.akpm@osdl.org>
 <41AEBAB9.3050705@pobox.com><20041201230217.1d2071a8.akpm@osdl.org>
 <179540000.1101972418@[10.10.2.4]><41AEC4D7.4060507@pobox.com>
 <20041202101029.7fe8b303.cliffw@osdl.org> <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
 <156610000.1102546207@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, Martin J. Bligh wrote:

> I tried benchmarking it ... but processes just segfault all the time.
> Any chance you could try it out on SMP ia32 system?

I tried it on my i386 system and it works fine. Sorry about the puny
memory sizes (the system is a PIII-450 with 384k memory)

clameter@schroedinger:~/pfault/code$ ./pft -t -b256000 -r3 -f1
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0   3    1    0.000s      0.004s   0.000s 37407.481  29200.500
  0   3    2    0.002s      0.002s   0.000s 31177.059  27227.723

clameter@schroedinger:~/pfault/code$ uname -a
Linux schroedinger 2.6.10-rc3-bk3-prezero #8 SMP Wed Dec 8 15:22:28 PST
2004 i686 GNU/Linux

Could you send me your .config?


