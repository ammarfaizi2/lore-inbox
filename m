Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319154AbSH2Jga>; Thu, 29 Aug 2002 05:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319155AbSH2Jga>; Thu, 29 Aug 2002 05:36:30 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:28578 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S319154AbSH2Jga>; Thu, 29 Aug 2002 05:36:30 -0400
Date: Thu, 29 Aug 2002 11:17:44 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: readsw/writesw readsl/writesl
Message-ID: <20020829111744.A223@linux-m68k.org>
References: <20020828142356.B4464@linux-m68k.org> <20020828161701.22623@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020828161701.22623@192.168.4.1>; from benh@kernel.crashing.org on Wed, Aug 28, 2002 at 06:17:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 06:17:01PM +0200, Benjamin Herrenschmidt wrote:

> Another possibility (that looks saner to me) would be to define that
> the IO macros take all a parameter which represents the bus (or rather
> the device pointer in the new driver model). Most archs would just
> ignore that macro parameter and so have exactly equivalent code as
> we have today, but that let archs that feel they need it to actually
> use that to go pick the proper access methods for that device.

that would certainly solve all problems.

> In all cases, though, I would keep the distinction between {read,write}*
> and {in,out}* as there are PCI drivers that will need to mix them.

sure, it makes a difference even on m68k ISA buses.

Richard
