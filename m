Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTFPTSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTFPTSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:18:04 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:63916 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263897AbTFPTSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:18:01 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Antonio Vargas <wind@cocodriloo.com>
Date: Mon, 16 Jun 2003 21:31:23 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: vmware strange scheduling priority
Cc: linux-kernel@vger.kernel.org, pme@hyglo.com
X-mailer: Pegasus Mail v3.50
Message-ID: <49A923E3DE6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 03 at 20:59, Antonio Vargas wrote:
> On Mon, Jun 16, 2003 at 08:39:38PM +0200, Peter Enderborg wrote:
> > Im playing with vmware 4.0 workstation. And it do some strange 
> > things.
> > I start vmware with nice and I got this:
> > 26499 pme       19  19 95980  93M 95020 R N    12 32.6 24.8   8:55 
> > vmware-vmx
> > 26439 pme       19  19  8416 8008  7692 R N     8  3.2  2.0   2:02 
> > vmware-vmx
> > 26492 pme        6 -10 95980  93M 95020 R <    12  2.6 24.8   0:34 
> > vmware-vmx
> > 26409 pme       19  19  4900 3916  2484 S N     0  1.0  1.0   0:29 
> > vmware
> > 26433 pme        5 -10  8416 8008  7692 S <     8  0.5  2.0   0:29 
> > vmware-vmx
> > 26493 pme        5 -10  8056 7268  6988 S <     0  0.5  1.8   0:20 
> > vmware-mks
> > 26495 pme        9   0 67672  65M 66888 S       0  0.2 17.4   0:11 
> > vmware-vmx
> > 
> > 
> > It have changed the prioority to -10 for some of its own tasks. How 
> > can that be done? Its a non suid binary started
> > by a normal user. It's very ugly, but Im more intressted in how it 
> > can be done.
> > The kernel is a 2.4.20.
> 
> pure guessing here...
> vmware relies on having kernel modules instaled.. perhaps
> the do an ioctl to enter the module and then they spin
> off some threads with nice -10 from inside?

Nope. vmware-vmx is suid...
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz

P.S.: And if you play with default priority for VMware, do not
complain that it is slow as a molase...

