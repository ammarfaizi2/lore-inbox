Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWDKVca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWDKVca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 17:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWDKVca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 17:32:30 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:46649 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751121AbWDKVc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 17:32:29 -0400
Message-ID: <443BFF0A.7050303@tmr.com>
Date: Tue, 11 Apr 2006 15:10:02 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060410 SeaMonkey/1.5a
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org,
       netfilter@lists.netfilter.org, davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>	<20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net>	<20060409074313.GZ15954@vianova.fi> <20060409144416.GO1686@vianova.fi>	<20060409144534.GN29797@vianova.fi> <87psjqg2nt.fsf@hades.wkstn.nix>
In-Reply-To: <87psjqg2nt.fsf@hades.wkstn.nix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:
> On 9 Apr 2006, Ville Herva yowled:
>> On Sun, Apr 09, 2006 at 05:44:16PM +0300, you [Ville Herva] wrote:
>>> I just realized 
>>> # CONFIG_NETFILTER_XT_MATCH_STATE is not set
>>> should probably be set. I'm building a new kernel now...
>> Ok, that seems to do it.
>>
>> Thanks for the help, and sorry for the noise. I hope not too many people hit
>> the same glitch while upgrading...
> 
> I cetainly did. A simple `make oldconfig' ends up zapping pretty much
> all the old iptables CONFIG_ options, so you end up with not much of
> iptables or netfilter left.
> 
> I must admit not quite understanding why the xtables stuff is needed:
> I thought that was needed for userspace connection tracking, which
> while it sounds cool isn't something I'm using yet.
> 
I think the root of the problem is that "make oldconfig" doesn't give 
any warning when options are removed. So there's no warning that 
iptables is gone, because the help for the new options doesn't tell you 
"replaces XXXX" even if you as for help.

Suggestion: how hard would it be to have some extra value like y/n/m 
which says print the help even though the option is gone? That would be 
a reasonable thing to do for a version or two after things go away, and 
certainly lower cost than having testers ask questions, rebuild kernels, 
or just go away mad.

