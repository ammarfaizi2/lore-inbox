Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUFVS3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUFVS3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUFVS23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:28:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:39915 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265232AbUFVSZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:25:41 -0400
Date: Tue, 22 Jun 2004 11:24:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, erikj@sgi.com
Subject: Re: [PATCH 2.6] Altix serial driver
Message-Id: <20040622112442.1e7387bb.akpm@osdl.org>
In-Reply-To: <200406221616.i5MGGCfL018095@fsgi900.americas.sgi.com>
References: <200406221616.i5MGGCfL018095@fsgi900.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat Gefre <pfg@sgi.com> wrote:
>
> 2.6 patch for our console driver. We converted the driver to use the
>  serial core functions. Also some changes to use sysfs/udev and a new
>  major number.

Well it doesn't use a new major, does it?

+#define DEVICE_MAJOR 204
+#define DEVICE_MINOR 40

Which is:

204 char	Low-density serial ports
		  0 = /dev/ttyLU0		LinkUp Systems L72xx UART - port 0
		    ...
		 32 = /dev/ttyDB0		DataBooster serial port 0
		    ...
		 39 = /dev/ttyDB7		DataBooster serial port 7

205 char	Low-density serial ports (alternate device)


which seems reasonable, I suppose, but a patch to devices.txt is needed
please.

