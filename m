Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276716AbRJHAPO>; Sun, 7 Oct 2001 20:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276718AbRJHAPE>; Sun, 7 Oct 2001 20:15:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40718 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276716AbRJHAO6>; Sun, 7 Oct 2001 20:14:58 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PCI problem with 2.4.10 on 82434LX chipset
Date: Mon, 8 Oct 2001 00:14:26 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9pqr52$7fu$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110072319040.2878-100000@apollos.ttu.ee>
X-Trace: palladium.transmeta.com 1002500102 7157 127.0.0.1 (8 Oct 2001 00:15:02 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Oct 2001 00:15:02 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110072319040.2878-100000@apollos.ttu.ee>,
david  <david@apollos.ttu.ee> wrote:
>
>PCI: PCI BIOS revision 2.10 entry at 0xfd6f2, last bus=0
>PCI: System does not support PCI
>
>Any hope getting PCI bus working on this box? Maybe some hints? Thanx :)

The type-2 config space accesses were broken in 2.4.10 due to an ACPI
rewrite, that got fixed in the 2.4.11-pre kernels (should be fixed in
pre1 already, but you might as well test pre5). 

Most people never noticed, because type 1 tends to be what most machines
use. 

The 2.4.11 kernels are under ftp.kernel.org:/pub/linux/kernel/testing,

		Linus
