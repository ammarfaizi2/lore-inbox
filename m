Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269547AbUINRCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269547AbUINRCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269630AbUINQ5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:57:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:17598 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269557AbUINQmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:42:21 -0400
Date: Tue, 14 Sep 2004 09:37:55 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Tonnerre <tonnerre@thundrix.ch>, ink@jurassic.park.msu.ru,
       linux-kernel@vger.kernel.org, greg@kroah.com, wli@holomorphy.com
cc: Hanna Linder <hannal@us.ibm.com>
Subject: Re: [RFT 2.6.9-rc1 alpha sys_sio.c] [2/2] convert pci_find_device to pci_get_device
Message-ID: <11190000.1095179875@w-hlinder.beaverton.ibm.com>
In-Reply-To: <20040914022125.GA20950@thundrix.ch>
References: <806430000.1095118643@w-hlinder.beaverton.ibm.com> <20040914002933.GA20390@thundrix.ch> <20040914020222.GB23058@twiddle.net> <20040914022125.GA20950@thundrix.ch>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, September 14, 2004 04:21:25 AM +0200 Tonnerre <tonnerre@thundrix.ch> wrote:
> On Mon, Sep 13, 2004 at 07:02:22PM -0700, Richard Henderson wrote:
>> On Tue, Sep 14, 2004 at 02:29:33AM +0200, Tonnerre wrote:
>> > Don't we need to put these devices in some place?
>> 
>> pci_get_device does that for non-null "from" argument.
> 
> I was talking about pci_put_device(dev)..
> 
> 				Tonnerre

Hi Tonnerre,

I believe that is what Richard is talking about as well. When pci_get_device
is in a while loop the dereference is done automatically. See the code and 
comments.

You will notice in the sys_alcor.c patch I did add the pci_dev_put (although
in the wrong place, new patch coming soon).

Regards,

Hanna


