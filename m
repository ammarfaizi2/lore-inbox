Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTLES3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTLES3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:29:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264269AbTLES3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:29:43 -0500
Message-ID: <3FD0CE84.8060902@pobox.com>
Date: Fri, 05 Dec 2003 13:29:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <20031204081732.GC5376@launay.org> <3FCF4C32.5040101@pobox.com> <200312051842.26599.marchand@kde.org> <3FD0C4B0.8020106@pobox.com> <3FD0CB76.4000202@backtobasicsmgmt.com>
In-Reply-To: <3FD0CB76.4000202@backtobasicsmgmt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:
> Jeff Garzik wrote:
> 
>> Yes, a tested patch would be great, thanks!
>>
> 
> (hijacking this subthread, sorry)
> 
> Jeff, you mentioned in the status report "don't remove an operating disk 
> from an ICH5, hotplug is not supported".
> 
> Does this mean hardware damage, or just serious libata/ICH5 confusion? 
> I've got a six-disk server here with two disks on an ICH5 and four on an 
> SATA150 TX4, and I really would like to be able to hot-replace a disk in 
> case of a failure. If the ICH5 cannort support this, I'm going to have 
> to get a 3ware card.


_Probably_ no hardware damage, but I do not know for sure.  I do not it 
will likely lockup, and data corruption is also a possibility.

As I mentioned in another email, ICH5 hardware does not support hot 
removal.  HOWEVER.  If the OS driver is given sufficient notice, it can 
shut down the port, and the sysadmin may then unplug the SATA cable.

As a tangent, your TX4 hardware fully supports hotplug, but libata does 
not yet support it.

	Jeff



