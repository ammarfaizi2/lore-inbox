Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965291AbVKGWD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbVKGWD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965320AbVKGWDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:03:25 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:48277 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965291AbVKGWDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:03:24 -0500
Date: Mon, 7 Nov 2005 16:03:14 -0600
To: Brian King <brking@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2/7]: Revised [PATCH 27/42]: SCSI: add PCI error recovery to IPR dev driver
Message-ID: <20051107220314.GP19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107195727.GF19593@austin.ibm.com> <20051107213003.GI19593@austin.ibm.com> <436FC9D0.4060803@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436FC9D0.4060803@us.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 03:40:32PM -0600, Brian King was heard to remark:
> linas wrote:
> > +/** ipr_eeh_slot_reset - called when pci slot has been reset.
> > + *
> > + * This routine is called by the pci error recovery recovery
> > + * code after the PCI slot has been reset, just before we
> > + * should resume normal operations.
> > + */
> > +static pers_result_t ipr_eeh_slot_reset(struct pci_dev *pdev)
> > +{
> > +	unsigned long flags = 0;
> > +	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
> > +
> > +	// pci_enable_device(pdev);
> > +	// pci_set_master(pdev);
> 
> I assume you want remove these two lines... The pci config space
> restore in ipr's reset handling should cover them.

Yes, I do. Its cruft left over from old test and debug cycles. :(

