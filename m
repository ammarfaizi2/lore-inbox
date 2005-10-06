Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVJFNgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVJFNgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVJFNgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:36:16 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52962 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750927AbVJFNgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:36:15 -0400
Message-ID: <4345284A.5060102@pobox.com>
Date: Thu, 06 Oct 2005 09:36:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
References: <20051005210610.EC31826369@lns1058.lss.emc.com> <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de> <43452315.7050801@pobox.com> <4345273B.40906@emc.com>
In-Reply-To: <4345273B.40906@emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Jeff Garzik wrote:
> 
>> Staring at the docs a bit, I notice that the 50xx and 60xx have SATA 
>> S{status,control,error} registers at different locations.
> 
> 
> 
> Yes and also even some registers that are at the same location have 
> changed bit definitions.  Aye caramba.
> 
> Best solution will probably be to create separate enums for each chip 
> generation, in addition to a common enum, and point to the relevant one 
> based on the chip identifier.
> 
> No surprise we're seeing so many problems.  I have just not spent any 
> time at all on 5xxx.  Probably should yank it from the pci device table 
> for now.

I would suggest submitting a patch to put #if 0 around the PCI table 
entries, so that testers can easily turn it back on...

	Jeff



