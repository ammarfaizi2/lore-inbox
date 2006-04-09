Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWDIQyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWDIQyD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDIQyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 12:54:03 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:8969 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750815AbWDIQyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 12:54:01 -0400
To: Patrick McHardy <kaber@trash.net>
Cc: vherva@vianova.fi, linux-kernel@vger.kernel.org,
       netfilter@lists.netfilter.org, davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
	<20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net>
	<20060409074313.GZ15954@vianova.fi> <20060409144416.GO1686@vianova.fi>
	<20060409144534.GN29797@vianova.fi> <87psjqg2nt.fsf@hades.wkstn.nix>
	<4439385B.6010908@trash.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: more boundary conditions than the Middle East.
Date: Sun, 09 Apr 2006 17:53:54 +0100
In-Reply-To: <4439385B.6010908@trash.net> (Patrick McHardy's message of "Sun, 09 Apr 2006 18:37:47 +0200")
Message-ID: <87hd52g065.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Apr 2006, Patrick McHardy murmured woefully:
> Nix wrote:
>>>Thanks for the help, and sorry for the noise. I hope not too many people hit
>>>the same glitch while upgrading...
>> 
>> 
>> I cetainly did. A simple `make oldconfig' ends up zapping pretty much
>> all the old iptables CONFIG_ options, so you end up with not much of
>> iptables or netfilter left.
> 
> But it does show you all the new options. Admittedly, it would
> have been better to automatically select the new options when
> needed, but probably not worth changing it now, it has been
> like this for two releases I think.

Oh, yes, it did, and I thought they were userspace-matching related and
left them off. The real problem is that oldconfig doesn't mention when
options you *had* enabled disappear.

>> I must admit not quite understanding why the xtables stuff is needed:
>> I thought that was needed for userspace connection tracking, which
>> while it sounds cool isn't something I'm using yet.
> 
> Its a unification of the matches and targets that are address family
> independant.

Ah, hence the ipv6-matching stuff turning up in 2.6.16. I see.

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
