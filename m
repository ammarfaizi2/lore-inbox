Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261928AbSI3Fc3>; Mon, 30 Sep 2002 01:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261929AbSI3Fc3>; Mon, 30 Sep 2002 01:32:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22022 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261928AbSI3Fc3>;
	Mon, 30 Sep 2002 01:32:29 -0400
Message-ID: <3D97E30E.50703@pobox.com>
Date: Mon, 30 Sep 2002 01:37:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Orinoco-devel] Re: Orinoco driver update
References: <20020927025227.GC1898@zax> <3D94B7F5.6030401@pobox.com> <20020930050846.GG10265@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Linus applied 0.13a and that fixes things, thanks.

Two quick comments:
* you need pci_set_drvdata(pdev,NULL) after pci_disable_disable in your 
pci_driver::remove hook
* I think it would look better to remove the struct pci_driver ->suspend 
and ->resume hook references, if they are NULL (0)...


