Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbSLQWYc>; Tue, 17 Dec 2002 17:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbSLQWYc>; Tue, 17 Dec 2002 17:24:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267153AbSLQWYb>;
	Tue, 17 Dec 2002 17:24:31 -0500
Message-ID: <3DFFA5DD.4030804@pobox.com>
Date: Tue, 17 Dec 2002 17:31:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: kill pdev_enable_device()
References: <20021217201938.A16940@jurassic.park.msu.ru>
In-Reply-To: <20021217201938.A16940@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> - So, if we don't touch the PCI command registers, there is no point in
>   using pdev_enable_device(). Most drivers properly use
>   pci_enable_device() anyway.


Not only that, a driver _should_ be calling pci-enable-device, it's an 
API requirement.  J Random Driver should have a good reason _not_ to 
call pci_enable_device() ...


