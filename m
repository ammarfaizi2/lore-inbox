Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291801AbSBNRj3>; Thu, 14 Feb 2002 12:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291802AbSBNRjT>; Thu, 14 Feb 2002 12:39:19 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:49169 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S291801AbSBNRjP>; Thu, 14 Feb 2002 12:39:15 -0500
Date: Thu, 14 Feb 2002 16:12:25 +0000
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
To: Harald Welte <laforge@gnumonks.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: 2.4.18-pre9: iptables screwed?
Message-ID: <20020214161225.A2867@axis.demon.co.uk>
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com> <20020208094649.J26676@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020208094649.J26676@sunbeam.de.gnumonks.org>; from laforge@gnumonks.org on Fri, Feb 08, 2002 at 09:46:49AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 09:46:49AM +0100, Harald Welte wrote:
> On Thu, Feb 07, 2002 at 08:24:28PM -0800, H. Peter Anvin wrote:
> > I get the following error with iptables on 2.4.18-pre9:
> > 
> > sudo iptables-restore < /etc/sysconfig/iptables
> > iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> > `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> > Abort (core dumped)

I've noticed this too.

Specifically it is fine with 2.4.17 but broken with 2.4.18-pre7-ac2

I use the mangle table to set the TOS for a few things but it gives
this error :-

  iptables -t mangle -A add-tos -p tcp --dport ssh -m tos --tos Minimize-Delay

  iptables: libiptc/libip4tc.c:384: do_check: Assertion `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.

> Could you please tell me, what iptables version are you using? 
> (btw: please follow-up to netfilter-devel@lists.samba.org)

This is using Redhat 7.2 iptables v1.2.4 from the redhat package
iptables-1.2.4-2.

Apologies if this info is too late but I didn't see a followup to
lkml.

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
