Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTIWXEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTIWXEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:04:22 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:8399 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263387AbTIWXEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:04:20 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: "David S. Miller" <davem@redhat.com>
Date: Wed, 24 Sep 2003 09:04:12 +1000
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923230412.GA30157@cse.unsw.EDU.AU>
References: <16234.36238.848366.753588@wombat.chubb.wattle.id.au> <20030919055304.GE16928@wotan.suse.de> <20030919064922.B3783@kvack.org> <16239.38154.969505.748461@wombat.chubb.wattle.id.au> <20030922203629.B21836@kvack.org> <20030922232237.28a5ac4a.davem@redhat.com> <16240.8965.91289.460763@wombat.chubb.wattle.id.au> <20030923035118.578203d5.davem@redhat.com> <16240.24511.375148.520203@napali.hpl.hp.com> <20030923102735.42a59d57.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923102735.42a59d57.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 10:27:35AM -0700, David S. Miller wrote:
> As I understand it, you even do this stupid printk for user apps
> as well, that makes it more than rediculious.
                                                                                                                                                      
Just as a point of interest, as an application programmer I think it's
the type of thing you want to know about quite loudly.  The only
benchmark style figure on this I've ever seen is in this paper
                                                                                                                                                      
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dv_vstechart/html/vcconWindowsDataAlignmentOnIPFX86X86-64.asp
                                                                                                                                                      
(forgive the long url) which, if you scroll down to the little graph,
shows OS fixup is about 450 times slower that an aligned access.  That
sucks, and if I didn't realise I'd done it, it would suck even more.

Oh, and I think fixing it up automatically & warning is much more
useful than sending a (by default) terminating signal to the program;
though I'm sure others might disagree.
                                                                                                                                                      
-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au
