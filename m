Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbULGRYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbULGRYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbULGRYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:24:06 -0500
Received: from [62.206.217.67] ([62.206.217.67]:15034 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261859AbULGRYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:24:01 -0500
Message-ID: <41B5E722.2080600@trash.net>
Date: Tue, 07 Dec 2004 18:23:46 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
CC: hadi@cyberus.ca, Andrew Morton <akpm@osdl.org>,
       Thomas Cataldo <tomc@compaqnet.fr>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
References: <1102380430.6103.6.camel@buffy> <20041206224441.628e7885.akpm@osdl.org> <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net> <20041207170748.GF1371@postel.suug.ch>
In-Reply-To: <20041207170748.GF1371@postel.suug.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf wrote:

>* Patrick McHardy <41B5E188.5050800@trash.net> 2004-12-07 17:59
>  
>
>>That's also what I thought at first. But the problem is in
>>tcf_action_copy_stats, it assumes a->priv has the same layout as
>>struct tcf_act_hdr, which is not true for struct tcf_police. This
>>patch rearranges struct tcf_police to match tcf_act_hdr.
>>    
>>
>
>Hehe, see my post a few minutes back. I came up with nearly the same
>solution ;-> The only difference to my patch is that I don't touch
>tcf_police if the action code isn't compiled.
>  
>
Either one is fine with me, although I would prefer to see
the number of ifdefs in this area going down, not up :)

Regards
Patrick


