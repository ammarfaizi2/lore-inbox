Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTH0LwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTH0LwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:52:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7134 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263316AbTH0LwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:52:05 -0400
Message-ID: <3F4C9B59.20504@pobox.com>
Date: Wed, 27 Aug 2003 07:51:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org> <20030722205629.GA27179@gtf.org> <20030722213926.GA4295@codepoet.org> <3F4C1F09.846A83EF@vtc.edu.hk> <3F4C2210.6050404@pobox.com> <20030827090020.GC9054@merlin.emma.line.org>
In-Reply-To: <20030827090020.GC9054@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Tue, 26 Aug 2003, Jeff Garzik wrote:
> 
> 
>>For the future, I'm currently whipping the libata internals into shape 
>>so that Promise may be supported.  Promise hardware supports native 
>>command queueing, a lot like many SCSI adapters.
> 
> 
> Is that true even for the older stuff such as a PDC20265?

PATA stuff will continue to be supported via drivers/ide, I'm only 
shooting for the newer SATA stuff.


> It appears that FreeBSD 4-STABLE blacklists some older (before-TX2)
> Promise chips because they apparently lock up when used with tagged
> command queueing. I haven't yet looked at the ATAng driver merged into
> FreeBSD 5-CURRENT.


ATA tagged command queueing is a bunch of crap.  :)  I'm not sure 
whether I want to implement it or not.

I was referring to _native_ command queueing.  ATA TCQ is something 
different.  ATA TCQ does not allow multiple outstanding scatter/gather 
tables to be sent to the host controller.   Native command queuing does.

	Jeff



