Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbTEAPr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbTEAPrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:47:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:21385 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261388AbTEAPrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:47:25 -0400
Date: Thu, 1 May 2003 09:01:37 -0700
From: Greg KH <greg@kroah.com>
To: Scott Robert Ladd <coyote@coyotegulch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /dev Questions
Message-ID: <20030501160137.GA30141@kroah.com>
References: <3EB1358C.1020808@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB1358C.1020808@coyotegulch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 10:56:12AM -0400, Scott Robert Ladd wrote:
> Why does /dev include devices that do not exist?

/dev is only a bunch of device nodes that knows nothing about any
devices physically present in the system.

devfs creates a dynamic filesystem that is managed by the kernel that
only shows the devices present in the kernel at that point in time.

udev attempts to manage a /dev partition from userspace by watching all
of the hotplug events coming from the kernel that announce device
removal and additions.

Hope this helps,

greg k-h
