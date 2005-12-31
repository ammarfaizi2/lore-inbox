Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVLaAxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVLaAxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVLaAxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:53:25 -0500
Received: from [81.2.110.250] ([81.2.110.250]:8598 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751222AbVLaAxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:53:25 -0500
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Boldi <a1426z@gawab.com>
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <200512302306.28667.a1426z@gawab.com>
References: <200512302306.28667.a1426z@gawab.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 31 Dec 2005 00:55:02 +0000
Message-Id: <1135990502.28365.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-30 at 23:06 +0300, Al Boldi wrote:
> > +3 - (NEW) paranoid overcommit The total address space commit
> > +      for the system is not permitted to exceed swap. The machine
> > +      will never kill a process accessing pages it has mapped
> > +      except due to a bug (ie report it!)
> 
> This one isn't in 2.6, which is critical for a stable system.

Actually it is

In the 2.4 case we took  "50% RAM + swap" as the safe sane world 'never
OOM kill' and to all intents and purposes it works. We also had a 100%
paranoia mode.

When it was ported to 2.6 (not by me) whoever did it very sensibly made
the percentage tunable and removed "mode 3" since its mode 2 0% ram and
can be set that way.

Alan

