Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSJAPHP>; Tue, 1 Oct 2002 11:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbSJAPHP>; Tue, 1 Oct 2002 11:07:15 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:32899 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261663AbSJAPHP>;
	Tue, 1 Oct 2002 11:07:15 -0400
Date: Tue, 1 Oct 2002 16:15:25 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "David L. DeGeorge" <dld@degeorge.org>, linux-kernel@vger.kernel.org
Subject: Re: CPU/cache detection wrong
Message-ID: <20021001151525.GA32467@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"David L. DeGeorge" <dld@degeorge.org>,
	linux-kernel@vger.kernel.org
References: <20021001111826.GA18583@suse.de> <Pine.GSO.3.96.1021001153347.13606C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021001153347.13606C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 03:35:54PM +0200, Maciej W. Rozycki wrote:


 > > Some of the tualatins have an errata which makes L2 cache sizing
 > > impossible. They actually report they have 0K L2 cache. By checking
 > > the CPU model, we can guess we have at least 256K (which is where Linux
 > > got that number from in your case). But this however means the 512K
 > > models will report as 256K too.
 > > To work around it, boot with cachesize=512 and all will be good.
 > 
 >  Strange -- why not to default to 256K and override it with the value
 > obtained from a cache descriptor if != 0, then?

Because the cache descriptor IS zero. So we default to 256K.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
