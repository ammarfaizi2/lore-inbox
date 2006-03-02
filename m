Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWCBVFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWCBVFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWCBVFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:05:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932537AbWCBVFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:05:44 -0500
Date: Thu, 2 Mar 2006 13:05:19 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: =?UTF-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-Id: <20060302130519.588b18a2.zaitcev@redhat.com>
In-Reply-To: <mailman.1141249502.22706.linux-kernel2news@redhat.com>
References: <200603012116.25869.rene@exactcode.de>
	<20060301213223.GA17270@kroah.com>
	<mailman.1141249502.22706.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006 22:42:35 +0100, René Rebe <rene@exactcode.de> wrote:

> > > drivers/usb/core/devio.c:86
> > > #define MAX_USBFS_BUFFER_SIZE   16384

> So, queing alot URBs is the recommended way to sustain the bus? Allowing
> way bigger buffers will not be realistic?

Have you ever considered how many TDs have to be allocated to transfer
a data buffer this big? No, seriously. If your application cannot deliver
the tranfer speeds with 16KB URBs, we ought to consider if the combination
of our USB stack, usbfs, libusb and the application ought to get serious
performance enhancing surgery. The problem is obviously in the software
overhead.

-- Pete
