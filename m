Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUHID2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUHID2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 23:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUHID2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 23:28:23 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:28304 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265897AbUHID2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 23:28:21 -0400
References: <bec878da04080819361445af2c@mail.gmail.com>
Message-ID: <cone.1092022093.780511.26660.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Kevin =?ISO-8859-1?B?TydTaGVh?= <mastergoon@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: nvidia oops 2.6.8-rc3-mm2
Date: Mon, 09 Aug 2004 13:28:13 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin O'Shea writes:

> I hope its ok to post about this here, but I thought it might be a
> kernel bug not nvidia.
> 
> This is the oops with the new 6111 driver (it worked fine on mm1).
> 
> Thanks,
> Kevin

> Call Trace:
>  [<c0114375>] io_apic_set_pci_routing+0x1e5/0x210

I quote from akpm's announcement:

- If some devices mysteriously stop working, try booting with pci=routeirq.
  If that fixes it, please send a report, Cc'ing bjorn.helgaas@hp.com.  See
  remove-unconditional-pci-acpi-irq-routing.patch

That looks like it might help your issue too since the oops talks about pci 
routing.

Cheers,
Con

