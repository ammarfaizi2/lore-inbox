Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275297AbTHITFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275299AbTHITFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:05:42 -0400
Received: from letku14.adsl.netsonic.fi ([194.29.195.14]:51717 "EHLO
	tupa.firmament.fi") by vger.kernel.org with ESMTP id S275297AbTHITFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:05:38 -0400
Date: Sat, 9 Aug 2003 22:04:05 +0300
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: Maxim Krasnyansky <maxk@qualcomm.com>, LKML <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: [PATCH 2.6.0-test3][BLUETOOTH] BUG fix for drivers/bluetooth/hci_usb.c
Message-ID: <20030809190405.GA27995@riihi.firmament.fi>
References: <1060434720.2511.45.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060434720.2511.45.camel@lima.royalchallenge.com>
User-Agent: Mutt/1.3.28i
From: =?iso-8859-1?Q?Taneli_V=E4h=E4kangas?= <taneli@firmament.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 06:41:59PM +0530, Vinay K Nallamothu wrote:
> Hi,
> 
> The patch below fixes two pointer reference bugs (shows up as compile
> time warnings given below) which wrongly take the address of "struct
> usb_interface*".
> 
> ============compiler warning============================
> drivers/bluetooth/hci_usb.c: In function `hci_usb_probe':
> drivers/bluetooth/hci_usb.c:786: warning: assignment from incompatible
> pointer type
> drivers/bluetooth/hci_usb.c:810: warning: assignment from incompatible
> pointer type

Hey, not only that, the fix also made bluetooth work for me (previously
it would just oops when loading hci-usb). Thanks a lot!

	Taneli

