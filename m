Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTGaShd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTGaShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 14:37:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42880 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262499AbTGaShc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 14:37:32 -0400
Date: Thu, 31 Jul 2003 19:37:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731183730.GA7803@mail.jlokier.co.uk>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <20030730202822.GG1873@lug-owl.de> <20030730215032.GA18892@vana.vc.cvut.cz> <1059606394.10505.24.camel@dhcp22.swansea.linux.org.uk> <20030731151020.GF6410@mail.jlokier.co.uk> <1059667304.16608.47.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059667304.16608.47.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > > And if the byte you are looking at was patched by another thread you've
> > > blown it. Your emulation can only be so good 8) People do stuff like
> > > patching instructions under software decode as a robustness check - its
> > > normally pretty amusing
> > 
> > On a uniprocessor 386, this is not a problem.  Just disable preemption
> > in the kernel decoder.
> 
> Wrong again. Thats a common myth but you see I can put the instruction on a page
> so that its executed from a page I just did a read() into in another process. If
> I'm really bored I'll use O_DIRECT but thats mostly for makign life really bad 
> for non cache coherent setups 8)

I wouldn't be surprised if even real CPUs mis-decode when there's a
concurrent DMA into the area they are reading instructions from! :)

-- Jamie
