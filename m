Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267238AbUH3Kbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUH3Kbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 06:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUH3Kbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 06:31:49 -0400
Received: from [195.23.16.24] ([195.23.16.24]:47276 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267238AbUH3Kbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 06:31:46 -0400
Message-ID: <4133020F.1060306@grupopie.com>
Date: Mon, 30 Aug 2004 11:31:43 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: Roger Luethi <rl@hellgate.ch>, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
References: <20040827122412.GA20052@k3.hellgate.ch>	 <20040827162308.GP2793@holomorphy.com>	 <20040828194546.GA25523@k3.hellgate.ch>	 <20040828195647.GP5492@holomorphy.com>	 <20040828201435.GB25523@k3.hellgate.ch>	 <20040829160542.GF5492@holomorphy.com>	 <20040829170247.GA9841@k3.hellgate.ch>	 <20040829172022.GL5492@holomorphy.com>	 <20040829175245.GA32117@k3.hellgate.ch>	 <20040829181627.GR5492@holomorphy.com>	 <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube>
In-Reply-To: <1093810645.434.6859.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.37; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
>...
> 
> This is crummy. It's done for wchan, since that is so horribly
> expensive, but I'm not liking the larger race condition window.
> Remember that PIDs get reused. There isn't a generation counter
> or UUID that can be checked.

I just wanted to call your attention to the kallsyms speedup patch that 
is now on the -mm tree.

It should improve wchan speed. My benchmarks for kallsyms_lookup (the 
function that was responsible for the wchan time) went from 1340us to 0.5us.

So maybe this is enough not to make wchan a special case anymore...

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
