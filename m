Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVF2AcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVF2AcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVF2AcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:32:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:16037 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262318AbVF2Aaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:30:46 -0400
Date: Tue, 28 Jun 2005 17:29:51 -0700
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, ak@muc.de,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 1/13]: PCI Err: pci.h header file changes
Message-ID: <20050629002951.GA17885@kroah.com>
References: <20050628235817.GA6324@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628235817.GA6324@austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 06:58:17PM -0500, Linas Vepstas wrote:
> @@ -673,6 +704,7 @@ struct pci_driver {
>  	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
>  	void (*shutdown) (struct pci_dev *dev);
>  
> +	struct pci_error_handlers err_handler;
>  	struct device_driver	driver;
>  	struct pci_dynids dynids;
>  };

Shouldn't that be a pointer and not the whole structure?  Wouldn't that
make it easier to "reuse" error handlers?

thanks,

greg k-h
