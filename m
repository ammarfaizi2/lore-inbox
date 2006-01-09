Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWAISR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWAISR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWAISR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:17:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44952 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964907AbWAISR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:17:56 -0500
Date: Mon, 9 Jan 2006 10:17:13 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: 2.6.15: usb storage device not detected
Message-Id: <20060109101713.469d3a7f.zaitcev@redhat.com>
In-Reply-To: <20060109130540.GB2035@zip.com.au>
References: <20060109130540.GB2035@zip.com.au>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006 00:05:50 +1100, CaT <cat@zip.com.au> wrote:

> kernel: [  111.330762] usb 1-5: new high speed USB device using ehci_hcd and address 3
> kernel: [  112.180267] ub(1.3): Stall at GetMaxLUN, using 1 LUN
> kernel: [  151.843141] usb 1-5: USB disconnect, address 3

This is very unusual. The quickest workaround is to unset CONFIG_BLK_DEV_UB,
like Alan said. But it is very curious how this could happen. Care to
collect a usbmon trace for me? There's a howto in
Documentation/usb/usbmon.txt

Thanks,
-- Pete
