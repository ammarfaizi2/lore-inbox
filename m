Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVAMBCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVAMBCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVAMA6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:58:09 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:57536 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261450AbVAMA4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:56:00 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] release_pcibus_dev() crash
Date: Wed, 12 Jan 2005 16:55:42 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com>
In-Reply-To: <1105576756.8062.17.camel@sinatra.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121655.42947.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 12, 2005 4:39 pm, John Rose wrote:
> The removal of the class device from sysfs is carried out explicitly by
> class_device_del(), which occurs prior to class_device_put().  The class
> device is gone from sysfs by the time class_device_put() is called.  As
> such, this release function should not carry out sysfs cleanups for the
> class device.
>
> I'm unsure how pci_remove_legacy_files() doesn't cause the same crash for
> those who implemented it, but I'll leave that alone for now.

Feel free to fix it too.  I haven't tested the removal case, so thanks for 
catching it.

Jesse
