Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbUKOI6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbUKOI6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 03:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKOI6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 03:58:12 -0500
Received: from canuck.infradead.org ([205.233.218.70]:26121 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261553AbUKOI6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 03:58:09 -0500
Subject: Re: [PATCH]eepro100 resume failure
From: Arjan van de Ven <arjan@infradead.org>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1100508410.32025.2.camel@sli10-desk.sh.intel.com>
References: <1100507449.31599.9.camel@sli10-desk.sh.intel.com>
	 <1100508226.2936.11.camel@laptop.fenrus.org>
	 <1100508410.32025.2.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Message-Id: <1100509081.2936.13.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 15 Nov 2004 09:58:02 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?ip=80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	pci_set_power_state(pdev, 0);
>  	pci_restore_state(pdev);
> +	pci_enable_device(pdev);
> +	pci_set_master(pdev);
>  

one more nitpick; pci_enable_device() already calls
pci_set_power_state()... isn't that double up now ?

