Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUAJPwc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUAJPwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:52:32 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:28294 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265221AbUAJPw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:52:29 -0500
Date: Sat, 10 Jan 2004 10:51:50 -0500
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-mm2] e100 driver hangs after period of moderate receive load
Message-ID: <20040110155150.GC23063@gnu.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E01034D50AD@orsmsx402.jf.intel.com> <Pine.LNX.4.44.0401091715010.3118-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401091715010.3118-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 05:17:40PM -0800, Feldman, Scott wrote:

> > > Is NAPI enabled for this driver?? The interrupt behavior seems normal
> > > for NAPI, but certainly the rest of the behavior does not...
> > 
> > Yes, NAPI was indeed enabled.
> > 
> > I 'went back' to 2.6.1-rc1 and that seems fine now.? Any patches you want
> > me to try on top of 2.6.0-mm2?
> 
> Lennert, would you mind trying this patch to verify that problem is fixed?
> 
> The driver was indicating skbs to the stack before h/w was done with the 
> DMA.  Not good.  That's what causes the corruption.  The stack free's the 
> skb, and then h/w writes to it's data area.

AFAICS, didn't help, I still get the slab corruption.  Anything else you
want me to try?  Do you want me to send the klogd output I get now?


--L
