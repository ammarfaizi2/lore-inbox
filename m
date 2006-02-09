Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWBIQZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWBIQZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWBIQZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:25:43 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:50328
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932579AbWBIQZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:25:43 -0500
Date: Thu, 9 Feb 2006 08:25:34 -0800
From: Greg KH <greg@kroah.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: megaraid bug in kobject_register when no device is present
Message-ID: <20060209162534.GA8572@kroah.com>
References: <Pine.SOC.4.61.0602091646050.19027@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0602091646050.19027@math.ut.ee>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 04:47:49PM +0200, Meelis Roos wrote:
> Loading megaraid modules when no actual cards are present yields this in 
> dmesg. 2.6.16-rc2+git.
> 
> megasas: 00.00.02.02 Mon Jan 23 14:09:01 PST 2006
> megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
> megaraid: 2.20.4.7 (Release Date: Mon Nov 14 12:27:22 EST 2005)
> kobject_register failed for megaraid (-17)

This means that the driver is trying to register with the same name as
another driver on the same bus.

Nice to see we at least recover from it and don't kill the kernel :)

thanks,

greg k-h
