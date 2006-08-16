Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWHPPRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWHPPRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWHPPRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:17:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:5840 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751196AbWHPPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:17:17 -0400
Date: Wed, 16 Aug 2006 17:11:19 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bill Nottingham <notting@redhat.com>
cc: "Giacomo A. Catenazzi" <cate@debian.org>,
       David Miller <davem@davemloft.net>, 7eggert@gmx.de,
       7eggert@elstempel.de, shemminger@osdl.org, mitch.a.williams@intel.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
In-Reply-To: <20060816133811.GA26471@nostromo.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0608161636250.2044@be1.lrz>
References: <6KfTz-OX-11@gated-at.bofh.it> <6KfTA-OX-15@gated-at.bofh.it>
 <E1GD8rX-0001cA-CV@be1.lrz> <20060815.171002.104028951.davem@davemloft.net>
 <44E2BC9C.1000101@debian.org> <20060816133811.GA26471@nostromo.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Bill Nottingham wrote:
> Giacomo A. Catenazzi (cate@debian.org) said: 

> > > Are you willing to work to add the special case code necessary to
> > > handle whitespace characters in the device name over all of the kernel
> > > code and also all of the userland tools too?
> > 
> > But if you don't handle spaces in userspace, you handle *, ?, [, ], $,
> > ", ', \  in userspace? Should kernel disable also these (insane device
> > chars) chars?
> 
> Don't forget unicode characters!

And long names or control characters.

> Seriously, while it might be insane to use some of these, I'm wondering
> if trying to filter names is more work than fixing the tools.

I think it's sane to avoid control characters and unicode/iso*, since they
can interfere with log output or analysis. I only thought about the kernel
itself and the corresponding userspace tools, which should handle any
character sequence just fine or could be easily fixed.

-- 
Top 100 things you don't want the sysadmin to say:
14. Any more trouble from you and your account gets moved to the 750
