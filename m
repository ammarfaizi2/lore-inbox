Return-Path: <linux-kernel-owner+w=401wt.eu-S932305AbXAONDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbXAONDj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbXAONDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:03:39 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:47550 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932305AbXAONDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:03:38 -0500
Date: Mon, 15 Jan 2007 14:01:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Patrick McHardy <kaber@trash.net>
cc: David Madore <david.madore@ens.fr>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] netfilter: implement TCPMSS target for IPv6
In-Reply-To: <45AB54E5.6060103@trash.net>
Message-ID: <Pine.LNX.4.61.0701151358130.13639@yvahk01.tjqt.qr>
References: <20070114192011.GA6270@clipper.ens.fr>
 <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr> <45AB3DCA.9020204@trash.net>
 <Pine.LNX.4.61.0701151109540.32479@yvahk01.tjqt.qr> <45AB54E5.6060103@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 15 2007 11:18, Patrick McHardy wrote:
>Jan Engelhardt wrote:
>> On Jan 15 2007 09:39, Patrick McHardy wrote:
>> 
>>>I'm not sure how well that will work (the IPv4/IPv6-specific stuff
>>>is spread over the entire target function), but its worth a try.
>> 
>> 
>> well here's a q: would a patch be accepted that changes
>> all ipt and ip6t modules to the new xt? Even if a module is only for
>> ipv4 or ipv6, I think it makes sense to reduce the number of
>> different *t structures floating around.
>
>If you're talking about using the xt-structures in net/ipv[46]/netfilter
>and removing the ipt/ip6t-wrappers, that would make sense IMO.

Yup. Should the files then be renamed/moved to net/netfilter/xt_[foobaz].c
in a second step?

Should I leave ipt_TCPMSS/ip6t_TCPMSS untouched while you are working on 
that one?


	-`J'
-- 
