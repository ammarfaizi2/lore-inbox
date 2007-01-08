Return-Path: <linux-kernel-owner+w=401wt.eu-S1751003AbXAHVWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbXAHVWt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbXAHVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:22:48 -0500
Received: from outbound-mail-75.bluehost.com ([69.89.20.10]:52583 "HELO
	outbound-mail-75.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751002AbXAHVWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:22:48 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] update MMConfig patches w/915 support
Date: Mon, 8 Jan 2007 13:22:46 -0800
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
References: <200701071142.09428.jbarnes@virtuousgeek.org> <20070108203212.GA15481@dspnet.fr.eu.org>
In-Reply-To: <20070108203212.GA15481@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701081322.47481.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 8, 2007 12:32 pm, Olivier Galibert wrote:
> > The routines could probably be consolidated into a single
> > probe_intel_9xx routine or something, but I really looked at that
> > yet (though there are many similarities between the 91[05], 945 and
> > 965 families, they may not be enough that the code would actually
> > be simpler if shared.
>
> The individual functions are so simple, it's probably way better for
> maintainance simplicity to keep them separate, at least for now.

Yeah, sounds good.

> > +	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0x48, 4, &pciexbar);
> > +
> > +	/* No enable bit or size field, so assume 256M range is enabled.
> > */ +	len = 0x10000000U;
> > +	pci_mmcfg_config_num = 1;
> > +
> > +	pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]),
> > GFP_KERNEL); +	pci_mmcfg_config[0].base_address = pciexbar;
>
> Hmmm, I'd mask out the reserved bits if I were you.  Paranoia :-)

Wouldn't hurt I suppose, want me to post a new patch?

Thanks,
Jesse
