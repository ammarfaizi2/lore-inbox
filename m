Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbUKAJfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUKAJfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUKAJfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:35:37 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:4102 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261744AbUKAJfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:35:22 -0500
Date: Mon, 1 Nov 2004 09:35:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [patch 1/2] fakephp: introduce pci_bus_add_device
Message-ID: <20041101093514.GA25921@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Hotplug List <pcihpd-discuss@lists.sourceforge.net>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com> <41687EBA.7050506@ppp0.net> <41688985.7030607@ppp0.net> <41693CF9.10905@ppp0.net> <20041030041615.GH1584@kroah.com> <41857C7A.2030007@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41857C7A.2030007@ppp0.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 12:59:54AM +0100, Jan Dittmer wrote:
> fakephp needs to add newly discovered devices to the global pci list.
> Therefore seperate out the appropriate chunk from pci_bus_add_devices
> to pci_bus_add_device to add a single device to sysfs, procfs
> and the global device list.
> 
> Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>
> 
> ===== drivers/pci/bus.c 1.9 vs edited =====
> --- 1.9/drivers/pci/bus.c       2004-04-11 00:27:59 +02:00
> +++ edited/drivers/pci/bus.c    2004-10-31 23:24:10 +01:00
> @@ -69,6 +69,24 @@
>  }
> 
>  /**
> + * add a single device
> + * @dev: device to add
> + *
> + * This adds a single pci device to the global
> + * device list and adds sysfs and procfs entries for it
> + */
> +void __devinit pci_bus_add_device(struct pci_dev *dev) {

the brace should go to a line of it's own

