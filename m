Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWJWPfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWJWPfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWJWPfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:35:50 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:25606 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964945AbWJWPft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:35:49 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Zhu Yi <yi.zhu@intel.com>
Subject: Re: 2.6.19-rc2: ieee80211/ipw2200 regression
Date: Mon, 23 Oct 2006 16:35:49 +0100
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, jketreno@linux.intel.com
References: <200610230244.43948.s0348365@sms.ed.ac.uk> <200610231422.07647.s0348365@sms.ed.ac.uk> <200610231454.00238.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610231454.00238.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231635.49869.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 14:54, Alistair John Strachan wrote:
> On Monday 23 October 2006 14:22, Alistair John Strachan wrote:
> > On Monday 23 October 2006 04:42, Zhu Yi wrote:
> > > On Mon, 2006-10-23 at 02:44 +0100, Alistair John Strachan wrote:
> > > > [alistair] 02:42 [~/linux-git] cat /boot/System.map-`uname -r` | grep
> > > > arc4
> > > > c01f7970 t arc4_crypt
> > > > c01f7a10 t arc4_set_key
> > > > c0341be0 d arc4_alg
> > > > c0390cc0 t arc4_init
> > > > c03a393c t __initcall_arc4_init
> > > > c03a6380 t arc4_exit
> > >
> > > It should be OK if you configured ARC4 and CRC32 in kernel. Can you
> > > also see the symbols in /proc/kallsyms? (In case
> > > /boot/System.map-`uname -r` differs with the currently running kernel.)
> >
> > You're right, they're not there. However the files were built at the same
> > time!
>
> Actually, sorry, I was looking at the wrong machine. They are indeed there:
>
> [alistair] 14:20 [~] cat /proc/kallsyms | grep arc4
>
> c01f7970 t arc4_crypt
> c01f7a10 t arc4_set_key
> c0390cc0 t arc4_init

Tried compiling as a module too and the ieee80211 system doesn't load arc4.ko 
before bailing out. If I reboot, load it myself and try again, it still 
doesn't work.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
