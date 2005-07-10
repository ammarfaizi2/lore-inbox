Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVGJMfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVGJMfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 08:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGJMfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 08:35:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:32737 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261914AbVGJMfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 08:35:23 -0400
Date: Sun, 10 Jul 2005 14:35:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Selhorst <selhorst@crypto.rub.de>, linux-kernel@vger.kernel.org,
       kjhall@us.ibm.com, adobriyan@gmail.com
Subject: Re: [PATCH] tpm: Support for new chip type
Message-ID: <20050710123550.GA3378@ucw.cz>
References: <42CDAFBA.5080005@crypto.rub.de> <20050709191903.GB1553@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709191903.GB1553@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 09:19:04PM +0200, Pavel Machek wrote:
 
> Ugh, is it just me or are you abusing enums a bit?
> > +static int __init tpm_inf_probe(struct pci_dev *pci_dev,
> > +				const struct pci_device_id *pci_id)
> > +{
> > +
> > +	int rc = 0;
> > +	u8 ioh;
> > +	u8 iol;
> 
> Put these two on one line? Are you sure probe can't be called during
> runtime for some pci hotplug case?
 
__devinit should be used here, if for nothing else, then for sanity's
sake.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
