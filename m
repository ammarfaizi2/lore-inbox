Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUH3NrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUH3NrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUH3NrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:47:04 -0400
Received: from [195.23.16.24] ([195.23.16.24]:42165 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268059AbUH3Nn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:43:57 -0400
Message-ID: <41332F19.9030402@grupopie.com>
Date: Mon, 30 Aug 2004 14:43:53 +0100
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
References: <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com> <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube> <4133020F.1060306@grupopie.com> <20040830105322.GE5492@holomorphy.com> <41331C57.3070304@grupopie.com> <20040830122854.GF5492@holomorphy.com>
In-Reply-To: <20040830122854.GF5492@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.37; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>This seems to go wrong on big-endian machines; any chance you could look
>>>over your stuff and try to figure out what endianness issues it may have?
> 
> 
> On Mon, Aug 30, 2004 at 01:23:51PM +0100, Paulo Marques wrote:
> 
>>I went over the code but at a first glance couldn't find a notorius 
>>trouble spot. I don't have big-endian hardware myself so this is hard to 
>>test.
>>Just a few questions to help me out in finding the problem:
>>- is this really an endianess problem or is it a 64-bit integer problem?
> 
> 
> Works fine on x86-64 and alpha. Prints gibberish on sparc64.
> 
> 
> On Mon, Aug 30, 2004 at 01:23:51PM +0100, Paulo Marques wrote:
> 
>>- are you cross compiling the kernel?
>>Thanks in advance,
> 
> 
> No. All native.

Can you send me an ".tmp_kallsyms2.S" obtained after a kernel build on a 
sparc64, so that I can isolate the problem between scripts/kallsyms.c 
and kernel/kallsyms.c?  (maybe gzip'ed and in private, because this can 
be a big file...)

Thanks for all the help in debugging this.

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
