Return-Path: <linux-kernel-owner+w=401wt.eu-S1752721AbWLOPLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbWLOPLM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbWLOPLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:11:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbWLOPLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:11:11 -0500
Message-ID: <4582BA68.1010303@redhat.com>
Date: Fri, 15 Dec 2006 10:08:24 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Import fw-sbp2 driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052253.7213.41796.stgit@dinky.boston.redhat.com> <45750C9A.607@garzik.org> <4581B88C.9040104@redhat.com> <4581C4D1.8090803@s5r6.in-berlin.de>
In-Reply-To: <4581C4D1.8090803@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Kristian Høgsberg wrote:
>> Jeff Garzik wrote:
>>> doesn't allowing the stack to issue REPORT LUNS take care of this?
>> Possibly, I don't have firewire multi-LUN devices to test with here. 
>> The LUNs are also discoverable from the firewire config rom, which is
>> why I put the comment there.  This doesn't mean that the SCSI commands
>> for discovering LUNs doesn't also work.
> 
> I expect REPORT LUNS won't work for many SBP-2 devices. It is not included
> in RBC.
> 
> We discover LUs properly from the information in the ISO 13213 ROM. We just
> don't map multiple LUs of the same target to scsi_device's beneath a single
> scsi_target. (We instantiate one Scsi_Host for each LU. I might implement
> a respective mapping some day, but there is no bigger benefit of doing so.)

Yeah, I saw that the stack creates a struct device per LUN, which is kinda 
gross in my opinion.  It's easy enough to discover the LUNs from the rom, I 
just need to figure out how to tell the SCSI stack about multiple LUNs.

Kristian


