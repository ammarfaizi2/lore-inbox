Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWIDBem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWIDBem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 21:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWIDBem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 21:34:42 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:39552 "EHLO
	asav05.insightbb.com") by vger.kernel.org with ESMTP
	id S932214AbWIDBel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 21:34:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAKcf+0SBT4lZLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/RFC 2.6.18-rc] platform_device_probe(), to conserve memory
Date: Sun, 3 Sep 2006 21:34:29 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>
References: <200609031823.05560.david-b@pacbell.net>
In-Reply-To: <200609031823.05560.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609032134.30195.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 September 2006 21:23, David Brownell wrote:
> This defines a new platform_driver_probe() method allowing the driver's
> probe() method, and its support code+data, to safely live in __init
> sections for common system configurations.
> 

If you do this you also need to kill drivers bind/unbind attributes
to show that dynamic [un]binding is not supported.

-- 
Dmitry

-- 
VGER BF report: H 0.000843217
