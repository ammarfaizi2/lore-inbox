Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbVALCEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVALCEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVALCEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:04:08 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:27573 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262978AbVALCCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:02:23 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andi Kleen <ak@muc.de>
Date: Wed, 12 Jan 2005 03:03:31 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: node_online_map patch kills x86_64
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org
X-mailer: Pegasus Mail v3.50
Message-ID: <624682967EF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 05 at 2:38, Andi Kleen wrote:
> On Tue, Jan 11, 2005 at 04:30:25PM -0800, Chris Wright wrote:
> > kernel direct mapping tables upto ffff810100000000 @ 8000-d000
> > PANIC: early exception rip ffffffff8078b2e3 error 0 cr2 17c498a67
> >   Filesystem type ext2
> >   (couple more grub messgages like kernel name, root device)
> 
> Can you please boot with earlyprintk=serial,ttyS0,baud and send the full
> boot log? 
> 
> And also look up where ffffffff8078b2e3 is in System.map.

You should go through your x86-64-bugs mailbox ;-)   I've sent two
"hacks" your way, with explanation.  It is not nice to have node_online_map
to initialize with '1', then your nodes are #1 and #2 instead of #0 and
#1, and as node #0 has no memory and is not online at all, things broke.
Plus k8topology is broken too.

http://www.x86-64.org/lists/bugs/msg01278.html

                                                Petr Vandrovec
                                                

