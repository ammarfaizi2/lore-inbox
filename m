Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUIAQCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUIAQCO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUIAP7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:59:04 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:50575 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267254AbUIAP6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:58:40 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <len.brown@intel.com>
Subject: Re: [2.6.9-rc1-bk7]  LIBATA - "irq 11: nobody cared" on sil 3112a
Date: Wed, 1 Sep 2004 09:58:31 -0600
User-Agent: KMail/1.6.2
Cc: Maciej =?iso-8859-1?q?G=F3rnicki?= <gutko@poczta.onet.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <566B962EB122634D86E6EE29E83DD808182C4C22@hdsmsx403.hd.intel.com> <1094005073.20110.50.camel@linux>
In-Reply-To: <1094005073.20110.50.camel@linux>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409010958.31256.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 9:39 pm, Len Brown wrote:
> I've got an NFORCE2 box, and it works either way,
> including putting both ohci_hcd and eth0 on irq 11
> at level/low in PIC mode like yours.
> 
> But in PIC mode I still get kernel: Disabling IRQ #7,
> so something isn't totally happy on this box.

Could it be that you just don't have anything important using IRQ 7
(it's parport on my box), while Maciej sees the hang because disabling
IRQ 11 kills his ATA controller?
