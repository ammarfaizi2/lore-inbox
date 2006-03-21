Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423095AbWCUSa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423095AbWCUSa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423100AbWCUSaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:30:24 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:53481 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1422967AbWCUSaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:30:22 -0500
Message-ID: <44204643.5040802@cfl.rr.com>
Date: Tue, 21 Mar 2006 13:30:27 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Gordon Atwood <gordon@cs.ualberta.ca>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata_promise does not see hardware RAID arrays on Fasttrak TX4000
References: <20060320194728.GA17279@cs.ualberta.ca> <441F0932.1080001@pobox.com> <20060321180118.GK17279@cs.ualberta.ca>
In-Reply-To: <20060321180118.GK17279@cs.ualberta.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2006 18:30:33.0724 (UTC) FILETIME=[8A56E3C0:01C64D15]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14337.000
X-TM-AS-Result: No--3.900000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gordon Atwood wrote:
> Why should I bother with dmraid when I should just go be able to go directly
> to sda-d, format them and then layer software RAID or LVM on top of that.
> I can set up the four disks as individual single-disk arrays in the Promise
> BIOS and away we go.
> 

The advantage to dmraid over mdraid or lvm is that with dmraid you can 
use the bios support to boot directly from the raid.  Another advantage 
is you can dual boot with windows on the array.  With lvm or dmraid you 
have to have a plain single disk boot partition to bring the system up.

> If the Promise card has overhead for processing I/O it will be there
> regardless of whether I go thru dmraid or mdadm or LVM.  At least in the
> latter configuration, I can always go out and get a real 4 port ide
> card and just hook up the disks to it.  Then this card can go in the
> trash.
> 

You can do this in either configuration.  If you configure the drives as 
a raid array using the bios/dmraid, then you can still plug them into 
another controller and dmraid will happily recognize them exactly the 
same way; you just won't be able to boot from the array.

> Thanks much for the pointer.  Interesting how no matter how hard you search,
> there is always a direct thread to the info that you want that you'll
> completely miss :-)
> 

