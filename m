Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWJPOja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWJPOja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWJPOja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:39:30 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:31499 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932098AbWJPOja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:39:30 -0400
Date: Mon, 16 Oct 2006 10:39:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 0/3] Driver core: Some probing changes
In-Reply-To: <20061016104407.0fc87c4c@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610161036120.7103-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Cornelia Huck wrote:

> Hi,
> 
> the following patches attempt to fix some issues in the current device
> probing code:
> 
> [1/3] Don't stop probing on ->probe errors.
> [2/3] Change function call order in device_bind_driver().
> [3/3] Per-subsystem multithreaded probing.
> 
> Patches are against -gkh tree. Works for me on s390 and on i386 with
> pci multithreaded probing enabled. (I also enabled multithreaded
> probing on the css and ccw busses in order to test the code on s390,
> but this doesn't make much sense since we already do async device
> recognition, so I'm not sending a patch.)

Your patch 2 looks fine.

Patch 1 is somewhat questionable.  Certainly the log message reporting the
error should be left in.  The other issue is whether to continue with
probing other drivers.  I guess there's no reason not to; stopping short
was merely an optimization.

I'll discuss patch 3 in a separate message.

Alan Stern

