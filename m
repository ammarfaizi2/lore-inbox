Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWASRtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWASRtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWASRtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:49:42 -0500
Received: from webapps.arcom.com ([194.200.159.168]:38927 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751374AbWASRtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:49:41 -0500
Message-ID: <43CFD12F.2070900@cantab.net>
Date: Thu, 19 Jan 2006 17:49:35 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch 0/2] driver core: platform_get_irq*(): return -ENXIO on error
References: <43BD534E.8050701@arcom.com> <20060105173717.GA11279@suse.de> <43BD5F5E.1070108@arcom.com> <20060105180815.GB13317@suse.de>
In-Reply-To: <20060105180815.GB13317@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2006 17:53:47.0734 (UTC) FILETIME=[4C44C760:01C61D21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq*() can't return 0 on error since 0 may be a valid IRQ.,
instead return a -ve error code.

platform_get_irq-return-error:
  - return -ENXIO if platform_get_irq*() can't find the resource.

platform_get_irq-fix-users-on-error:
  - fix all the users of platform_get_irq*() so they do something
sensible when it returns an error.

David Vrabel
