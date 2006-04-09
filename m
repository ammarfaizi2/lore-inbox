Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWDIQkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWDIQkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 12:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDIQkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 12:40:22 -0400
Received: from stinky.trash.net ([213.144.137.162]:58774 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750811AbWDIQkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 12:40:21 -0400
Message-ID: <4439385B.6010908@trash.net>
Date: Sun, 09 Apr 2006 18:37:47 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: vherva@vianova.fi, linux-kernel@vger.kernel.org,
       netfilter@lists.netfilter.org, davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>	<20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net>	<20060409074313.GZ15954@vianova.fi> <20060409144416.GO1686@vianova.fi>	<20060409144534.GN29797@vianova.fi> <87psjqg2nt.fsf@hades.wkstn.nix>
In-Reply-To: <87psjqg2nt.fsf@hades.wkstn.nix>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:
> On 9 Apr 2006, Ville Herva yowled:
> 
>>On Sun, Apr 09, 2006 at 05:44:16PM +0300, you [Ville Herva] wrote:
>>
>>>I just realized 
>>># CONFIG_NETFILTER_XT_MATCH_STATE is not set
>>>should probably be set. I'm building a new kernel now...
>>
>>Ok, that seems to do it.
>>
>>Thanks for the help, and sorry for the noise. I hope not too many people hit
>>the same glitch while upgrading...
> 
> 
> I cetainly did. A simple `make oldconfig' ends up zapping pretty much
> all the old iptables CONFIG_ options, so you end up with not much of
> iptables or netfilter left.

But it does show you all the new options. Admittedly, it would
have been better to automatically select the new options when
needed, but probably not worth changing it now, it has been
like this for two releases I think.

> I must admit not quite understanding why the xtables stuff is needed:
> I thought that was needed for userspace connection tracking, which
> while it sounds cool isn't something I'm using yet.

Its a unification of the matches and targets that are address family
independant.
