Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUGQBk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUGQBk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 21:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266676AbUGQBk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 21:40:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:43214 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266674AbUGQBk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 21:40:27 -0400
Date: Fri, 16 Jul 2004 18:39:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: davidm@hpl.hp.com
cc: Mark Haverkamp <markh@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <16632.28018.130890.290832@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0407161837260.20824@ppc970.osdl.org>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
 <20040711123803.GD21264@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org> <16626.62318.880165.774044@napali.hpl.hp.com>
 <Pine.LNX.4.58.0407122358570.13111@devserv.devel.redhat.com>
 <1089734729.1356.79.camel@markh1.pdx.osdl.net> <16632.28018.130890.290832@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Jul 2004, David Mosberger wrote:
> 
> Am I missing something?

No. Using "def_flags" was a mistake for the whole VM_EXEC thing. It's not 
designed for that, and it doesn't work that way. I applied the paper-over 
fix that gets it almost-working, but I'm waiting for Ingo to rewrite it by 
just saving the "executable_stack" information at exec time, and not 
playing with def_flags at all.

And if somebody else beats him to it, all the more power to that person,
hint hint ;)

		Linus
