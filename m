Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTKJQ0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTKJQ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:26:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263936AbTKJQ0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:26:42 -0500
Message-ID: <3FAFBC28.5000600@pobox.com>
Date: Mon, 10 Nov 2003 11:26:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Oliver M. Bolzer" <oliver@gol.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Success with  Promise FastTrak S150 TX4 (Re: [BK PATCHES] libata
 fixes)
References: <20031108172621.GA8041@gtf.org> <20031110095248.GA20497@magi.fakeroot.net>
In-Reply-To: <20031110095248.GA20497@magi.fakeroot.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver M. Bolzer wrote:
> On Sat, Nov 08, 2003 at 12:26:21PM -0500, Jeff Garzik <jgarzik@pobox.com> wrote...
>  
> 
>><jgarzik@redhat.com> (03/11/06 1.1415)
>>   [libata] fix ugly Promise interrupt masking bug
> 
> 
> This solved the last outstanding problem with the 4th drive and the
> driver seems to find all drives and properly boot off them, at least
> in a situation where no RAID-functionalty of the card is used. Great
> Work.

Thanks for testing.


> # A first quick run of bonnie++ seems to show 2.6.0-test9+libata several
> # %s slower then 2.4.22+ft3xx, but that might be related to differences
> # between 2.4 and 2.6.

One possibility is that queueing is not yet enabled in my sata_promise 
driver.  Several of the SATA drivers support having multiple commands 
outstanding per driver (tagged command queueing), but I need to do a bit 
more work before I can enable queueing in the core.

	Jeff


