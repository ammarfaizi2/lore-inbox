Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUATCyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUATCuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:50:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:21963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265298AbUATCqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:46:25 -0500
Date: Mon, 19 Jan 2004 18:46:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       jkenisto@us.ibm.com, scott.feldman@intel.com, kessler@us.ibm.com
Subject: Re: [PATCH 2.6.1] Net device error logging
Message-Id: <20040119184630.5d066735.akpm@osdl.org>
In-Reply-To: <400C3D3E.BFCC25CE@us.ibm.com>
References: <400C3D3E.BFCC25CE@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Keniston <jkenisto@us.ibm.com> wrote:
>
> The enclosed patch implements the netdev_* error-logging macros for
>  network drivers.

Looks OK to me.

But it does make one wonder whether we'll soon see standalone patches for
scsi_printk(), pci_bridge_printk(), random_other_subsystem_printk(), ...?

Or is it intended that the backend logging code will be implemented mainly
in terms of the `struct device'?  So netdev_printk() will be a bit of
netdev-specific boilerplate which then calls into a more generic
device_printk()?

