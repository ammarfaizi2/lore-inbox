Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTEVWXD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTEVWXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:23:03 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:28903 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263317AbTEVWXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:23:02 -0400
Date: Thu, 22 May 2003 23:36:16 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI changes for 2.5.69
Message-ID: <20030522223616.GA5830@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030522220251.GA6814@kroah.com> <10536411591193@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10536411591193@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 03:05:59PM -0700, Greg KH wrote:

 > One may write new PCI device IDs into the new_id file:
 > echo "8086 1229" > new_id
 > 
 > which will cause a new device ID (sysfs name 0) to be added to the driver.

Why not call the probe routine at this point ?
This would do away with the need for the probe_it file.
The only downside I can see is that if we have a script
echoing lots of device id updates, we're going to lots of
additional (-ENODEV) probes.

		Dave

