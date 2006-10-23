Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWJWNyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWJWNyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWJWNyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:54:03 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:29200 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751187AbWJWNyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:54:01 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Zhu Yi <yi.zhu@intel.com>
Subject: Re: 2.6.19-rc2: ieee80211/ipw2200 regression
Date: Mon, 23 Oct 2006 14:54:00 +0100
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, jketreno@linux.intel.com
References: <200610230244.43948.s0348365@sms.ed.ac.uk> <1161574972.19188.42.camel@debian.sh.intel.com> <200610231422.07647.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610231422.07647.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231454.00238.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 14:22, Alistair John Strachan wrote:
> On Monday 23 October 2006 04:42, Zhu Yi wrote:
> > On Mon, 2006-10-23 at 02:44 +0100, Alistair John Strachan wrote:
> > > [alistair] 02:42 [~/linux-git] cat /boot/System.map-`uname -r` | grep
> > > arc4
> > > c01f7970 t arc4_crypt
> > > c01f7a10 t arc4_set_key
> > > c0341be0 d arc4_alg
> > > c0390cc0 t arc4_init
> > > c03a393c t __initcall_arc4_init
> > > c03a6380 t arc4_exit
> >
> > It should be OK if you configured ARC4 and CRC32 in kernel. Can you also
> > see the symbols in /proc/kallsyms? (In case /boot/System.map-`uname -r`
> > differs with the currently running kernel.)
>
> You're right, they're not there. However the files were built at the same
> time!

Actually, sorry, I was looking at the wrong machine. They are indeed there:

[alistair] 14:20 [~] cat /proc/kallsyms | grep arc4

c01f7970 t arc4_crypt
c01f7a10 t arc4_set_key
c0390cc0 t arc4_init

>
> [alistair] 14:20 [~] ls -lah /boot/*2.6.19-rc2*
> -rw-r--r--  1 root root  36K 2006-10-13 21:46 /boot/config-2.6.19-rc2
> -rw-r--r--  1 root root 798K 2006-10-13 21:46 /boot/System.map-2.6.19-rc2
> -rw-r--r--  1 root root 1.7M 2006-10-13 21:46 /boot/vmlinuz-2.6.19-rc2
>
> Maybe it's a problem with the crypto subsystem?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
