Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTDOOqd (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTDOOqd 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:46:33 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.26]:1451 "EHLO
	mwinf0504.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261620AbTDOOqb (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 10:46:31 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: BUGed to death
Date: Tue, 15 Apr 2003 16:58:10 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304151639.25978.baldrick@wanadoo.fr> <70620000.1050417924@[10.10.2.4]>
In-Reply-To: <70620000.1050417924@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304151658.10495.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > No, I meant what happens if BUG() is non-trivial and BUG_ON is a no-op.
> > I thought it might give an indication of whether time was being lost
> > evaluating the condition (occurs with BUG and BUG_ON), or mispredicting
> > the branch (only occurs with BUG).
>
> Mmmm. wouldn't that just optimise away the BUG_ONs, but not the BUGs ?
> Which will tell you something, but I'm not sure anything interesting.
> My impression is that if I do:
>
> if (foo)
> 	do {} while (0);
>
> the compiler will just ditch the whole thing, and not evaluate foo.
> I'll admit to not having checked that, but still ....

Good point.  So much for trying to get info without converting a bunch
of BUG's into BUG_ON's...

Duncan.
