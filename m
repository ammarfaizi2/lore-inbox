Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291957AbSBNW2t>; Thu, 14 Feb 2002 17:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291952AbSBNW2j>; Thu, 14 Feb 2002 17:28:39 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:7554 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S291948AbSBNW2f>;
	Thu, 14 Feb 2002 17:28:35 -0500
Subject: Re: 2.4.18-pre9: iptables screwed?
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020214161225.A2867@axis.demon.co.uk>
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com>
	<20020208094649.J26676@sunbeam.de.gnumonks.org> 
	<20020214161225.A2867@axis.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 14 Feb 2002 17:28:34 -0500
Message-Id: <1013725714.2183.10.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-14 at 11:12, Nick Craig-Wood wrote:
> On Fri, Feb 08, 2002 at 09:46:49AM +0100, Harald Welte wrote:
> > On Thu, Feb 07, 2002 at 08:24:28PM -0800, H. Peter Anvin wrote:
> > > I get the following error with iptables on 2.4.18-pre9:
> > > 
> > > sudo iptables-restore < /etc/sysconfig/iptables
> > > iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> > > `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> > > Abort (core dumped)
> 
> I've noticed this too.
> 
> Specifically it is fine with 2.4.17 but broken with 2.4.18-pre7-ac2
> 
> I use the mangle table to set the TOS for a few things but it gives
> this error :-
> 
>   iptables -t mangle -A add-tos -p tcp --dport ssh -m tos --tos Minimize-Delay
> 
>   iptables: libiptc/libip4tc.c:384: do_check: Assertion `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> 
> > Could you please tell me, what iptables version are you using? 
> > (btw: please follow-up to netfilter-devel@lists.samba.org)
> 
> This is using Redhat 7.2 iptables v1.2.4 from the redhat package
> iptables-1.2.4-2.
> 
> Apologies if this info is too late but I didn't see a followup to
> lkml.

Upgrade iptables rpm.  I got 1.2.5 and this went away, but comes back in
2.4.17.

------
Michael Cohen
OhDarn.net

> -- 
> Nick Craig-Wood
> ncw@axis.demon.co.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


