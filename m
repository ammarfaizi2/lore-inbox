Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVAPKht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVAPKht (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 05:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVAPKht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 05:37:49 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:29243 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262473AbVAPKhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 05:37:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=buZ4UgH7vvAXe/PIOxPqlRCsvj+q3/H2d5oVgooQC89YFVJl+QxiE8LltnHQiyla4lIbOMAn5RpJBYBM0ledFkiD1svfiz0aZa3QsltfT85A9+VHo1EP9qjQKTWSsmNlcffakl7QPp/6u+rG4njCFnsz54L0HQPjwDuPAFuv7Rc=
Message-ID: <21d7e99705011602373ec9d777@mail.gmail.com>
Date: Sun, 16 Jan 2005 21:37:41 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Helge Hafting <helgehaf@aitel.hist.no>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391050116023344a5f954@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <21d7e997050113130659da39c9@mail.gmail.com>
	 <20050115185712.GA17372@hh.idb.hist.no>
	 <21d7e997050116020859687c4a@mail.gmail.com>
	 <9e473391050116023344a5f954@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>         /* There are signatures in BIOS and PCI-SSID for a PCI card,
> but they are not very reliable.
>         Following detection method works for all cards tested so far.
>         Note, checking AGP_ENABLE bit after drmAgpEnable call can also
> give the correct result.
>         However, calling drmAgpEnable on a PCI card can cause some
> strange lockup when the server
>         restarts next time.
>         */
>         pci_read_config_dword(dev->pdev, RADEON_AGP_COMMAND_PCI_CONFIG, &save);
>         pci_write_config_dword(dev->pdev, RADEON_AGP_COMMAND_PCI_CONFIG,
>                                save | RADEON_AGP_ENABLE);
>         pci_read_config_dword(dev->pdev, RADEON_AGP_COMMAND_PCI_CONFIG, &temp);
>         if (temp & RADEON_AGP_ENABLE)
>                 dev_priv->flags |= CHIP_IS_AGP;
>         DRM_DEBUG("%s card detected\n",
>                   ((dev_priv->flags & CHIP_IS_AGP) ? "AGP" : "PCI"));
>         pci_write_config_dword(dev->pdev, RADEON_AGP_COMMAND_PCI_CONFIG, save);

perhaps the stuff from Mike Harris in the latest radeon_driver.c in
Xorg might be a better idea..

Dave.
