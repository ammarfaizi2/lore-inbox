Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUIUWdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUIUWdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 18:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUIUWdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 18:33:51 -0400
Received: from imap.gmx.net ([213.165.64.20]:22197 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266585AbUIUWds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 18:33:48 -0400
X-Authenticated: #1725425
Date: Wed, 22 Sep 2004 00:36:46 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@osdl.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Message-Id: <20040922003646.3a84f4c5.Ballarin.Marc@gmx.de>
In-Reply-To: <1095803902.1942.211.camel@bach>
References: <1095721742.5886.128.camel@bach>
	<20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
	<1095803902.1942.211.camel@bach>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 07:58:22 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Sure, but you have to start somewhere.  Next step will be #error.  Then
> finally remove the whole thing (I don't want to remove the whole thing
> to start with, since that would create a silent failure).

I was rather thinking of some prominent printks at module init time.
People using distro kernels will never see compile time warnings.

I just added some warnings, but modprobe ipchains always fails on
2.6.9-rc2:

FATAL: Error inserting ipchains
(/lib/modules/2.6.9-rc2-rcf/kernel/net/ipv4/netfilter/ipchains.ko): Device
or resource busy

in log buffer:
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 332 bytes per
conntrack
Unable to register netfilter socket option

Am I missing something?

Regards
