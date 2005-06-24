Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbVFXPmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbVFXPmt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVFXPjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:39:12 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:23566 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S263051AbVFXPft
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:35:49 -0400
Message-ID: <42BC284E.7050202@rtr.ca>
Date: Fri, 24 Jun 2005 11:35:42 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: SATA speed. Should be 150 or 133?
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl> <42BB794B.6080109@rtr.ca> <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl>
In-Reply-To: <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> True SATA drives ignore the "transfer speed",
>> as it really is meaningless and does not apply.
> 
> So, am I the the only person confused by this message? ;)
> There is "SATA max UDMA/133" not "PATA max UDMA/133".

No, it really is as confusing as it sounds!
The drive is SATA, but the transfer speed gunk only
applies to the internal "PATA" portion of the drive,
which communicates to the built-in SATA bridge chip
of the same drive, which in turn presents a pure SATA
interface to the host computer.

> Oh, so how to check true (current) speed?

Same as always:  hdparm -I /dev/sd?
(requires the libata-dev "passthru" patch
recently reposted here by Jeff Garzik).

cheers
