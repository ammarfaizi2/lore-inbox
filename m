Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUEVQEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUEVQEm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 12:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUEVQEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 12:04:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34750 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261605AbUEVQEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 12:04:40 -0400
Date: Sat, 22 May 2004 12:03:28 -0400
From: Alan Cox <alan@redhat.com>
To: hch@infradead.org, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com,
       akpm@osdl.orgy
Subject: Re: PATCH: Stop megaraid trashing other i960 based devices
Message-ID: <20040522160328.GA22256@devserv.devel.redhat.com>
References: <20040522154659.GA17320@devserv.devel.redhat.com> <20040522160205.GA8643@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522160205.GA8643@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 12:02:05PM -0400, hch@infradead.org wrote:
> > +		   	return -ENODEV;
> > +		/* Now check the magic signature byte */
> > +		pci_read_config_word(pdev, PCI_CONF_AMISIG, &magic);
> > +		if(magic != HBA_SIGNATURE_471 && magic != HBA_SIGNATURE)
> > +			return -ENODEV;
> > +		/* Ok it is probably a megaraid */
> > +	}
> 
> I think we should add all valid subvendor ids to the pci_id table instead.
> Especially to not consude the hotplug package.

Most of the megaraids don't have subvendor ids... so that doesn't work at
all.



