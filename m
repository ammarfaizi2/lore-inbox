Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUC2T75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbUC2T75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:59:57 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25613 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263117AbUC2T7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:59:55 -0500
Date: Mon, 29 Mar 2004 21:57:36 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Len Brown <len.brown@intel.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Message-ID: <20040329195736.GC18399@alpha.home.local>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local> <200403290901.47695.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403290901.47695.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 09:01:47AM +0200, Denis Vlasenko wrote:
> > > 4. re-implement locks for the 80386 case.
> >
> > I like this one, but a simpler way : don't support SMP in this case, so
> > that we won't have to play with locks. This would lead to something like
> > this :
> 
> Yes, SMP makes sense only on 486+

Indeed, Andi made a good point : some people compile for 386 as a generic
target which can potentially run on more recent hardware with ACPI support.
May be we should consider this behaviour broken anyway, since there are
other features that will never be available, such as TSC. So why not simply
disable ACPI for 386 ?

> Inline func please. We definitely don't want to evaluate
> lock and old expressions several times.

That's right. But I'm too lazy this evening for something which has too few
chances of being the definitive solution :-)

Cheers,
willy

