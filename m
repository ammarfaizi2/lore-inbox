Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUBZK5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 05:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUBZK5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 05:57:55 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:13066 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262768AbUBZK5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 05:57:39 -0500
Date: Thu, 26 Feb 2004 10:57:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: i2c on alpha - used but not available in 2.6.3
Message-ID: <20040226105737.A17579@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakub Bogusz <qboosh@pld-linux.org>, linux-kernel@vger.kernel.org
References: <20040225160833.GA5803@gruby.cs.net.pl> <20040225161441.A6161@infradead.org> <20040226105357.GF19602@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040226105357.GF19602@gruby.cs.net.pl>; from qboosh@pld-linux.org on Thu, Feb 26, 2004 at 11:53:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:53:57AM +0100, Jakub Bogusz wrote:
> - beside drivers/i2c there was no drivers/misc and drivers/telephony in
>   alpha/Kconfig - was this intentional or accidental?
> 
>   drivers/misc currently contains only IBM_ASM, which looks like some
>   hardware-specific driver - maybe it should be available only on some
>   arch(s)?

drivers/misc/ is empty here, and until we have some policy decision it
should stay that way.  What tree do you look at?

> - on alpha drivers/parport was placed in "System setup" menu - but
>   I suppose it can be moved to standard location without problems

Yes.

> - drivers/message/fusion was included only conditionaly, depending on
>   PCI option (in drivers/Kconfig it's unconditional).
>   If message/fusion requires PCI, maybe it should have "depends on PCI"
>   in its Kconfig?

Yes, this is probably worth fixing.

