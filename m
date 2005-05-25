Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVEYBkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVEYBkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 21:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVEYBku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 21:40:50 -0400
Received: from zorg.st.net.au ([203.16.233.9]:62640 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S262233AbVEYBke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 21:40:34 -0400
Message-ID: <4293D798.4020606@torque.net>
Date: Wed, 25 May 2005 11:40:40 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: monz@danbbs.dk
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [ANNOUNCE] sdparm 0.92
References: <428DC633.5050403@torque.net> <4293BD80.1050503@danbbs.dk>
In-Reply-To: <4293BD80.1050503@danbbs.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mogens Valentin wrote:
> Douglas Gilbert wrote:
> 
>> sdparm is a command line utility designed to get and set
>> SCSI disk parameters (cf hdparm for ATA disks). More generally
>> it gets and sets mode page information on SCSI devices or devices
>> that use a SCSI command set (e.g. CD/DVD drives (any transport)
>> and SCSI tape drives). It also can list VPD pages including
>> the device identification page.
>>
>> For more information and downloads (tarball, rpm and deb
>> packages) see:
>> http://www.torque.net/sg/sdparm.html
> 
> 
> Nice! Just got it and tried on an external usb disk.
> One feature I could use, probably others as well:
> Could you add the ability to spin down/up a scsi disk?
> I'd really like this for exteral (usb) disks.

Mogens,
With sg_start (in the sg3_utils package) I have tried
to spin up and down an ATA disk inside a USB enclosure
without success. The same command on a USB connected
CD/DVD combo drive did work.

Could you try sg_start on your USB external enclosure
which I assume contains an ATA disk rather than a
SCSI (SPI) disk and report if it works?

BTW I just checked libata (for SATA disks) and it does
not seem to support the START STOP UNIT command.
Jeff, could that one be added?

> Doesn't seem it can; if I missed it, I'm sorry..

It is hard to know where to stop with sdparm ;-)
At the moment I am adding transport (protocol) specific
mode page support. So currently sdparm specializes
in mode pages (for all SCSI command sets) and INQUIRY
information (including the device identification VPD
page).

Doug Gilbert

