Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262623AbTCYMgD>; Tue, 25 Mar 2003 07:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbTCYMgC>; Tue, 25 Mar 2003 07:36:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29618
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262623AbTCYMgA>; Tue, 25 Mar 2003 07:36:00 -0500
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless
	looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alexander Atanasov <alex@ssi.bg>, linux@brodo.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <Pine.LNX.4.10.10303242014430.8000-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10303242014430.8000-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048600799.28496.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Mar 2003 13:59:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 04:16, Andre Hedrick wrote:
> This is one thing all of you don't get about hotplug.
> 
> You are not allowed on PATA, only SATA.
> 
> The BIOS and setup on the HBA's need a kick to come alive.
> There are basic hooks that do not permit post boot hotplug in PATA.

Several vendors support bus tristate handling. We now do error
handling on that. Its a first step towards being able to rescan
the bus.

