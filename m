Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUKOJCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUKOJCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 04:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUKOJCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 04:02:04 -0500
Received: from fmr12.intel.com ([134.134.136.15]:21379 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261560AbUKOJA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 04:00:56 -0500
Subject: Re: [PATCH]eepro100 resume failure
From: Li Shaohua <shaohua.li@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1100509081.2936.13.camel@laptop.fenrus.org>
References: <1100507449.31599.9.camel@sli10-desk.sh.intel.com>
	 <1100508226.2936.11.camel@laptop.fenrus.org>
	 <1100508410.32025.2.camel@sli10-desk.sh.intel.com>
	 <1100509081.2936.13.camel@laptop.fenrus.org>
Content-Type: text/plain
Message-Id: <1100508891.32025.5.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 16:54:51 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-15 at 16:58, Arjan van de Ven wrote:
> > +	pci_set_power_state(pdev, 0);
> >  	pci_restore_state(pdev);
> > +	pci_enable_device(pdev);
> > +	pci_set_master(pdev);
> >  
> 
> one more nitpick; pci_enable_device() already calls
> pci_set_power_state()... isn't that double up now ?
> 
I think 'pci_restore_state' should be called after
'pci_set_power_state'.

Thanks,
Shaohua

