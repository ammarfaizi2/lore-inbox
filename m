Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264172AbTCXMfr>; Mon, 24 Mar 2003 07:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264173AbTCXMfr>; Mon, 24 Mar 2003 07:35:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56488
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264172AbTCXMfq>; Mon, 24 Mar 2003 07:35:46 -0500
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless
	looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Atanasov <alex@ssi.bg>
Cc: Dominik Brodowski <linux@brodo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net>
References: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048514373.25136.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 13:59:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 09:55, Alexander Atanasov wrote:
> i can't reproduce the hang but it seems that drives without driver can get
> both in ata_unused and idedefault_driver.drives and lists go nuts.
> It kills ata_unused and uses idedefault_driver.drives only,
> boots fine here. I'd guess you have ide-cd as module, and the two drives
> handled by it couse the trouble - first joins the lists second couses the
> loop.

We need to know the difference between the two really so I would much rather
ensure we don't end up on both lists at once (which is a bug) than lose a
list

