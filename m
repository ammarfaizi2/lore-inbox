Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTGHKrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbTGHKrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:47:55 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:31873 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S264202AbTGHKrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:47:09 -0400
Date: Tue, 8 Jul 2003 13:01:22 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Peter C. Ndikuwera" <pndiku@dsmagic.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       Martin Schlemmer <azarah@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       smiler@lanil.mine.nu, KML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Message-ID: <20030708110122.GA10756@vana.vc.cvut.cz>
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu> <1057647818.5489.385.camel@workshop.saharacpt.lan> <20030708072604.GF15452@holomorphy.com> <200307081051.41683.schlicht@uni-mannheim.de> <20030708085558.GG15452@holomorphy.com> <1057657046.1819.11.camel@mufasa.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057657046.1819.11.camel@mufasa.ds.co.ug>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 12:37:26PM +0300, Peter C. Ndikuwera wrote:
> The VMware patches are ...
> 
> ftp://platan.vc.cvut.cz/pub/vmware/vmware-any-any-updateXX.tar.gz

vmware-any-any-update35.tar.gz should work on 2.5.74-mm2 too.
But it is not tested, I have enough troubles with 2.5.74 without mm patches...

> > On Tue, Jul 08, 2003 at 10:51:39AM +0200, Thomas Schlichter wrote:
> > > Btw, what do you think about the idea of exporting the follow_pages()
> > > function from mm/memory.c to kernel modules? So this could be used
> > > for modules compiled for 2.[56] kernels and the old way just for 2.4
> > > kernels...
> > 
> > I don't really have an opinion on it, but it's not my call.

vmmon started using 'get_user_pages' for locking pages some time ago. 
Unfortunately userspace needs looking at VA->PA mapping from time to time 
although it already retrieved this information at the time get_user_pages() 
was invoked :-( It makes userspace simpler, and it was also much faster than
any other solution before pmd/pte moved into the high memory.
						Best regards,
							Petr Vandrovec
