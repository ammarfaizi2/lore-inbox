Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTG1NqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265870AbTG1NqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:46:24 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:54150 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S263187AbTG1NqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:46:22 -0400
Date: Mon, 28 Jul 2003 16:01:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
       Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 problem
In-Reply-To: <20030728115924.GB1706@win.tue.nl>
Message-ID: <Pine.GSO.3.96.1030728155303.15233A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Andries Brouwer wrote:

> On Mon, Jul 28, 2003 at 12:25:05PM +0100, Alan Cox wrote:
> > On Llu, 2003-07-28 at 02:55, Pete Zaitcev wrote:
> > > 
> > > I see the light now. Somehow I imagined that atkbd code does not call
> > > the ->open for the port. Now it all falls into place. Everything works
> > > with a bigger timeout.
> > 
> > Unfortunately with this change several people still report failures
> 
> Ach. One bug fixed and the Linux kernel is still not perfect?
> What a pity.
> 
> [But yes, as I also said to someone else: on i386 one has a working
> keyboard after bootup. No initialization and no probing required.
> The new keyboard code uses a lot of knowledge about common keyboards
> and keyboard controllers. It works in most cases. But already the
> linux-kernel readers see a long stream of problems. I am afraid of
> the effect on a million Linux users.]

 Well, are timeouts needed at all, except for a single initial command to
see if a device is there?  I would imagine the keyboard to be initialized
using an interrupt-driven state machine. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

