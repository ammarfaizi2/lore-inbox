Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUIPNsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUIPNsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUIPNsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:48:46 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:3200 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S268060AbUIPNsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:48:40 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
Date: Thu, 16 Sep 2004 14:48:38 +0100
User-Agent: KMail/1.7
Cc: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
In-Reply-To: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161448.39033.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 Sep 2004 05:48, Sergei Haller wrote:
> Hello,
>
> A friend of mine has a new Opteron based machine (Tyan Tiger K8W with two
> Opteron 24?) and 4GB main memory.

Typo? Tyan Thunder?

>
> the problem is that about 512 MB of that memory is lost (AGP aperture and
> stuff). Although everything is perfect otherwise.
> As far as I understand, all the PCI/AGP hardware uses the top end of the
> 4GB address range to access their memory and there is just an
> "overlapping" of the addresses. thus only the remaining 3.5 GB are
> available.
>
>
> Now there is an option in the BIOS called "Adjust Memory" which puts a
> certain amount of memory (several choices between 64MB and 2GB) above the
> 4GB address range. I tried the 2GB setting which results in 2GB main
> memory at addresses 0-2GB and 2GB memory at addresses 4GB-6GB.
>

Ok;

Assuming bios version 2.02. (upgrade if you haven't already);

The option you mention should be set to 'Auto'

Chipset->Northbridge->Memory Configuration->Adjust Memory = Auto

but set

Advanced->Cpu Configuration->MTRR Mapping = Continuous

That fixed it for me if I remember correctly :)

Andrew Walrond
