Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbUBJOLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUBJOLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:11:35 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:3458 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265904AbUBJOLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:11:33 -0500
Date: Tue, 10 Feb 2004 15:11:19 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 crash after network link failure
Message-ID: <20040210141118.GA14719@vana.vc.cvut.cz>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDE6C@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDE6C@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 03:37:48PM -0800, Feldman, Scott wrote:
> > I think what might be happening is that somehow the TX queue 
> > is corrupted if
> > e100_config() runs (due to link UP state change) while there 
> > are active normal SKB packets on the TX queue.  Or perhaps 
> > some TX queue handling locking issue.
> > 
> > Scott, any ideas?
> 
> e100 hardware will continue to process the hardware's Tx queue even
> after link is lost, and then cleanup (return skbs) on interrupt.  I
> would expect e100 to be holding no Tx skbs when link returned.
> 
> Petr, -mm kernel has an updated (and much simpler) e100 driver.  Is this
> something you can try?  The switch failure can be simulated by manually
> plugging the cable in/out.

Unfortunately it does not seem easily triggerable. I spent about one
hour plugging/unplugging cable while transmitting UDP packets as fast
as possible, sometime interleaved with 'mii-tool -r', and it refused
to crash...
						Petr Vandrovec

