Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbVHEWN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbVHEWN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVHEWNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:13:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:61345 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263141AbVHEWL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:11:56 -0400
Date: Fri, 5 Aug 2005 15:11:35 -0700
From: Greg KH <greg@kroah.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Dave Jones <davej@redhat.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com
Subject: Re: [Pcihpd-discuss] Re: [PATCH] use bus_slot number for name
Message-ID: <20050805221135.GA3782@kroah.com>
References: <1123269366.8917.39.camel@whizzy> <20050805195123.GN2241@redhat.com> <1123277467.8917.58.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123277467.8917.58.camel@whizzy>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 02:31:07PM -0700, Kristen Accardi wrote:
> +#define HPSLOT_NAME_SIZE BUS_ID_SIZE 
> +static inline void pci_hp_make_slot_name(struct hotplug_slot *hpslot, struct pci_dev *pdev)
> +{
> +	snprintf(hpslot->name, HPSLOT_NAME_SIZE, "%s", pci_name(pdev));
> +}

I don't think that others can use this, as you can have multiple struct
pci_dev for the same "slot".

thanks,

greg k-h
