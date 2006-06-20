Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWFTQsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWFTQsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWFTQsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:48:14 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:39856 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751411AbWFTQsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:48:13 -0400
Date: Tue, 20 Jun 2006 10:48:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Matt LaPlante <laplam@rpi.edu>, "'Linus Torvalds'" <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
Message-ID: <20060620164811.GM1630@parisc-linux.org>
References: <Pine.LNX.4.64.0606201742280.12900@scrub.home> <000601c69481$a9f86c40$fe01a8c0@cyberdogt42> <20060620160128.GL1630@parisc-linux.org> <Pine.LNX.4.64.0606201809100.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606201809100.17704@scrub.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 06:12:50PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Tue, 20 Jun 2006, Matthew Wilcox wrote:
> > The *default* is N as that's the answer most people want.  The *safe*
> > answer is Y as it won't prevent you from getting access to your data.
> > Makes sense?
> 
> This would imply that most people with 32bit systems have 2TB files, which 
> I think is rather unlikely. Distributions can turn this option on, but I 
> think people who compile their own kernel, either understand this option 
> or don't need it.

I think it implies exactly the opposite.

In any case, the length of this thread answers your question from earlier:
No, I won't fix bug 6719 as part of this patch.  It's a completely
unrelated issue and the problem is ill-defined.  It's also something
that's infinitely arguable.

The original patch is simple and fixes one problem: that architecture
people are supposed to learn about LSF and LBD when it really has no
effect on their architecture.

