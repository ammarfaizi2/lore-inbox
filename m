Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUHCVxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUHCVxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUHCVxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:53:22 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:48595 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266894AbUHCVwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:52:14 -0400
Date: Tue, 3 Aug 2004 23:51:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803215150.GM2241@dualathlon.random>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random> <20040803211339.GB26620@devserv.devel.redhat.com> <20040803213634.GK2241@dualathlon.random> <20040803213856.GB10978@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803213856.GB10978@devserv.devel.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 11:38:57PM +0200, Arjan van de Ven wrote:
> On Tue, Aug 03, 2004 at 11:36:34PM +0200, Andrea Arcangeli wrote:
> > On Tue, Aug 03, 2004 at 11:13:39PM +0200, Arjan van de Ven wrote:
> > > The user that mlock'd gets to pay for it, and gets his credits back at
> > > munlock. Chown doesn't really matter in that regard..... The thing that does
> > 
> > what? he cannot get credits when it munlock if this is hugetlbfs. If it
> > does you're again into the insecure DoS scenario.
> 
> not if you keep track of who locked in the first place and give the credit
> back to *that* user (struct).

I wasn't talking about chown above. I mean, where's the truncate that
releases the user-struct-bind? You just can't release the
user-struct-bind from
munlock/exit/whatever-task-opeartion-different-from-truncate-or-chown.

