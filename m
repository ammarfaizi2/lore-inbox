Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261828AbTCQRic>; Mon, 17 Mar 2003 12:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbTCQRic>; Mon, 17 Mar 2003 12:38:32 -0500
Received: from havoc.daloft.com ([64.213.145.173]:14747 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261828AbTCQRib>;
	Mon, 17 Mar 2003 12:38:31 -0500
Date: Mon, 17 Mar 2003 12:49:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Philippe De Muyter <phdm@macqel.be>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: sundance DFE-580TX DL10050B patch
Message-ID: <20030317174920.GC9667@gtf.org>
References: <20030317172416.GA3366@suse.de> <200303171740.h2HHebY01003@mail.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303171740.h2HHebY01003@mail.macqel.be>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 06:40:36PM +0100, Philippe De Muyter wrote:
> Dave Jones wrote :
> > On Mon, Mar 17, 2003 at 02:56:09PM +0100, Philippe De Muyter wrote:
> > 
> >  > +		writew((dev->dev_addr[i + 1] << 8) + dev->dev_addr[i],
> > 
> > Don't you want to OR those together instead of add them ?
> > 
> > 		Dave
> > 
> You're right.

No.

Adding and or'ing are exactly equivalent for the above case, where you
shift an 8-bit value left 8 bits, then add it to another 8-bit value.

The final answer may be obtained from examining the compiler's assembly
output, and see which combination ('or' or 'add') produces the best
code.

	Jeff



