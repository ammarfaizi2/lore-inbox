Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269574AbUJFX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269574AbUJFX1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269634AbUJFXZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:25:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:61127 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269574AbUJFXW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:22:26 -0400
Subject: Re: Probable module bug in linux-2.6.5-1.358
From: Stephen Hemminger <shemminger@osdl.org>
To: "Richard B.Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
Content-Type: text/plain
Organization: Open Source Development Lab
Date: Wed, 06 Oct 2004 16:22:04 -0700
Message-Id: <1097104924.26149.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 18:08 -0400, Richard B. Johnson wrote:
> The attached script shows that an attempt to open a device
> after its module was removed, will seg-fault the kernel.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
>              Note 96.31% of all statistics are fiction.



Oct  6 17:03:30 chaos kernel: Analogic Corp Datalink Driver : Module
removed

The bug is in that driver. It needs to unregister the character device
in it's module remove routine.  It doesn't appear to be in the main
kernel source tree so bug Redhat or the vendor.

