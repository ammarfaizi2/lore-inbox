Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbWBUVAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWBUVAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWBUVAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:00:11 -0500
Received: from mail.suse.de ([195.135.220.2]:54957 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932767AbWBUVAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:00:09 -0500
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags into pci_device_id
Date: Tue, 21 Feb 2006 21:59:51 +0100
User-Agent: KMail/1.8.2
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
References: <43FAB283.8090206@jp.fujitsu.com> <43FAB375.2020007@jp.fujitsu.com> <20060221205640.GA12423@kroah.com>
In-Reply-To: <20060221205640.GA12423@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212159.52106.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 21:56, Greg KH wrote:

> I don't think you can add fields here, after the driver_data field.  It
> might mess up userspace tools a lot, as you are changing a userspace
> api.

User space should look at the ASCII files (modules.*), not the binary
As long as the code to generate these files still works it should be ok.

> Do you _really_ need to pass this information back from userspace to the
> driver in this manner?

Well driver_data wouldn't be needed then either. Obviously it's for more
than just userspace.

-Andi

 
