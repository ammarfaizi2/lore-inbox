Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272141AbTHFVmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272355AbTHFVmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:42:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:20194 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272141AbTHFVmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:42:09 -0400
Date: Wed, 6 Aug 2003 14:39:41 -0700
From: Greg KH <greg@kroah.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test2: Lost USB mouse after resuming from S3
Message-ID: <20030806213941.GA7618@kroah.com>
References: <200308070037.31630.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308070037.31630.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 12:37:31AM +0800, Michael Frank wrote:
> Causes are that usb-host controller does no handle S3 yet _plus_
> possibly (depending on your hardware) loss of PCI interrupt links as
> current ACPI does not resume those.

Known issue, please unload the usb modules before suspending them.

The upcoming suspend patches will allow us to fix this "properly",
please give us a few weeks :)

thanks,

greg k-h
