Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUH3MXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUH3MXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUH3MXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:23:53 -0400
Received: from [195.23.16.24] ([195.23.16.24]:6834 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267793AbUH3MXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:23:51 -0400
Message-ID: <41331C57.3070304@grupopie.com>
Date: Mon, 30 Aug 2004 13:23:51 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
References: <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com> <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube> <4133020F.1060306@grupopie.com> <20040830105322.GE5492@holomorphy.com>
In-Reply-To: <20040830105322.GE5492@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.37; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Albert Cahalan wrote:
> 
>>>This is crummy. It's done for wchan, since that is so horribly
>>>expensive, but I'm not liking the larger race condition window.
>>>Remember that PIDs get reused. There isn't a generation counter
>>>or UUID that can be checked.
> 
> 
> On Mon, Aug 30, 2004 at 11:31:43AM +0100, Paulo Marques wrote:
> 
>>I just wanted to call your attention to the kallsyms speedup patch that 
>>is now on the -mm tree.
>>It should improve wchan speed. My benchmarks for kallsyms_lookup (the 
>>function that was responsible for the wchan time) went from 1340us to 0.5us.
>>So maybe this is enough not to make wchan a special case anymore...
> 
> 
> This seems to go wrong on big-endian machines; any chance you could look
> over your stuff and try to figure out what endianness issues it may have?

I went over the code but at a first glance couldn't find a notorius 
trouble spot. I don't have big-endian hardware myself so this is hard to 
test.

Just a few questions to help me out in finding the problem:

- is this really an endianess problem or is it a 64-bit integer problem?

- are you cross compiling the kernel?

Thanks in advance,

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
