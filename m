Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVAMVSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVAMVSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVAMVHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:07:24 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35728 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261673AbVAMVFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:05:03 -0500
Date: Thu, 13 Jan 2005 13:05:01 -0800
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] release_pcibus_dev() crash
Message-ID: <20050113210501.GA31402@kroah.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com> <1105638551.30960.16.camel@sinatra.austin.ibm.com> <20050113181850.GA24952@kroah.com> <200501131021.19434.jbarnes@engr.sgi.com> <20050113183729.GA25049@kroah.com> <1105647135.30960.22.camel@sinatra.austin.ibm.com> <20050113202532.GA30780@kroah.com> <1105649679.30960.27.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105649679.30960.27.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 02:54:39PM -0600, John Rose wrote:
> > Care to redo this?
> 
> Good points.  How's this:

Closer (you forgot a changelog entry too...)

>  }
>  #else /* !HAVE_PCI_LEGACY */
>  static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
> -static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
> +void pci_remove_legacy_files(struct pci_bus *bus) { return; }
>  #endif /* HAVE_PCI_LEGACY */

What about the HAVE_PCI_LEGACY version of the file?

thanks,

greg k-h
