Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUAUSCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUAUSCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:02:05 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:37649 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265989AbUAUSCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:02:01 -0500
Date: Wed, 21 Jan 2004 18:01:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Moore, Eric Dean" <Emoore@lsil.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] show "Fusion MPT device support" menu only if BLK _DEV_SD
Message-ID: <20040121180154.A32424@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Moore, Eric Dean" <Emoore@lsil.com>, Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E5703A75F51@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703A75F51@exa-atlanta.se.lsil.com>; from Emoore@lsil.com on Wed, Jan 21, 2004 at 12:00:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 12:00:09PM -0500, Moore, Eric Dean wrote:
> The "config FUSION" entry in Kconfig is handling both mptbase.ko 
> and mptscsih.ko for some reason?
> 
> The mptbase.ko driver is the lower layer driver which configures
> the adapters and is transport layer to and from the chip. It doesn't
> depend on anything in the scsi mid layer.  
> 
> The mptscsih.ko does depend on scsi_mod.ko, but not sd.ko  
> 
> Therefore - maybe we could have separate entries in Kconfig for
> both mptbase and mptscsih.  mptbase depend on PCI, and mptscsih
> depend on SCSI. What do you think?

Sounds good.  (And mptscsi should depend on mptbase of course)

