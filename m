Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSLMS4v>; Fri, 13 Dec 2002 13:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSLMS4v>; Fri, 13 Dec 2002 13:56:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7180 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265262AbSLMS4v>;
	Fri, 13 Dec 2002 13:56:51 -0500
Message-ID: <3DFA2F19.3000004@pobox.com>
Date: Fri, 13 Dec 2002 14:03:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Valdis.Kletnieks@vt.edu, Petr Konecny <pekon@informatics.muni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions)
References: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu> <200212131633.gBDGX0617899@anxur.fi.muni.cz> <200212131718.gBDHIw27008173@turing-police.cc.vt.edu> <20021213173656.GC1633@suse.de>
In-Reply-To: <20021213173656.GC1633@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> It's my understanding that pci_enable_device() *must* be called
> before we fiddle with dev->resource, dev->irq and the like.


True and correct, but -- this particular case is inside the cardbus 
core, where it presumeably might have a better idea of when it is best 
to call pci_enable_device (or perhaps even not at all, and twiddle the 
bits itself).

