Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269564AbUI3V6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269564AbUI3V6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269574AbUI3V6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:58:11 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:5351 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S269564AbUI3V6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:58:01 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.9-rc3: USB OHCI failure on suspend on AMD64
Date: Thu, 30 Sep 2004 14:58:01 -0700
User-Agent: KMail/1.6.2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <200409302251.30903.rjw@sisk.pl>
In-Reply-To: <200409302251.30903.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409301458.01099.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 1:51 pm, Rafael J. Wysocki wrote:
> Hi,
> 
> It seems there's a problem with USB OHCI driver that causes these traces to 
> appear on suspend on an AMD64-based box:

Not all parts of power management integrate well yet with each other,
though it's acting better.  Plus there are some OHCI updates in the USB
patches (you'll have those in the MM tree) that help address some of
the more perverse ways that suspend-to-disk kicks USB around, and
a few similar usbcore changes that need re-integration with the RC3
swsusp/pmdisk updates.

Keep using the "rmmod" workaround for now.  And don't combine
CONFIG_USB_SUSPEND with suspend-to-{disk,ram} unless you're
feeling like debugging the results.

- Dave
