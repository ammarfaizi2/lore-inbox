Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTDVPN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTDVPNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:13:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20446
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263201AbTDVPNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:13:25 -0400
Subject: Re: Linux 2.4.20 + SiS + Adaptec AHA-7850
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: war <war@lucidpixels.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0304212236380.12135@p300>
References: <Pine.LNX.4.55.0304212236380.12135@p300>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051021577.14880.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Apr 2003 15:27:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-22 at 03:38, war wrote:
> Does not work...
> Boots up, probes each ID, fails, takes 15-20 sec per timeout for each ID,
> then actually does boot after (15-20sec)*7ID for that board.
> 
> I used same exact (SCSI-CONFIG) for VIA board, worked fine, guess there
> are problems with IRQs or something?

If you are using SiS SMP boards or have built for local apic support it
will fail with most SiS boards. Linux and SiS APIC don't get on with one
another (we trigger a chip quirk). Boot with "noapic" option if so.

2.5.x does handle this

