Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTLJTZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTLJTZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:25:31 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:653 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263914AbTLJTZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:25:21 -0500
Date: Wed, 10 Dec 2003 19:16:48 +0000
From: Dave Jones <davej@redhat.com>
To: Chris Petersen <Chris.Petersen@synopsys.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FIXED (was Re: PROBLEM:  Blk Dev Cache causing kswapd thrashing)
Message-ID: <20031210191648.GI5661@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Petersen <Chris.Petersen@synopsys.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311271649520.21568-100000@logos.cnet> <3FD75B8A.21FA59D9@synopsys.com> <20031210180849.GA13303@redhat.com> <3FD76D99.1960A104@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD76D99.1960A104@synopsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:01:45PM -0500, Chris Petersen wrote:

 > After some research it looks like the fix is sortof there in
 > RedHat's 2.4.20-13.7.  It behaves better, but not as good as 2.4.23
 > or 2.4.20-24.7.  By "better" I mean kswapd (and bdflush, kupdated,
 > kreclaimd) doesn't hog the CPU(s) as much; but it still does to
 > a greater extent compared to what I'm calling the "fixed" versions.
 > So in 2.4.20-13.7 it's quasi-busted or quasi-fixed, depending on
 > your half-full/empty position.

Red Hat's 2.4.20 based kernels include the rmap VM.
Due to this fixes that have gone into mainline vm may or may not
be relevant. You may notice the same bug affecting both, but they're
not necessarily fixed in the same way.

 > I suppose I am working from the assumption that if vanilla
 > (kernel.org) 2.4.20 was fixed then 2.4.21-4EL would also be fixed
 > (which it's not).  It would seem to me that a kernel's got no
 > business calling itself 2.4.21-<anything> if it's not based off of
 > previous kernel base.  Otherwise, "21" has absolutely no meaning.

2.4.20-x.7 is a 2.4.20 kernel with additional patches.
2.4.21-4EL is a 2.4.21 kernel with additional patches.

I.e., they _are_ based off the previous kernel base.

What you've seen is that something got fixed for one product
but not for another. Hardly surprising considering the VM
for those kernels is quite different.  If the 2.4.21-4EL kernel
still suffers this bug, file it in bugzilla.

 > Imperical evidence seems to indicate that vanilla 2.4.20 does not
 > contain the fix.  Whereas something that RedHat calls 2.4.20-XYZ does.

See above. The VM in Red Hat's 2.4.20 works completely differently
to mainline.

		Dave

