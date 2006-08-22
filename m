Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWHVGih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWHVGih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 02:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWHVGih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 02:38:37 -0400
Received: from stinky.trash.net ([213.144.137.162]:1009 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1751051AbWHVGig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 02:38:36 -0400
Message-ID: <44EAA669.7050604@trash.net>
Date: Tue, 22 Aug 2006 08:38:33 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter@lists.netfilter.org
Subject: Re: ipt_MARK/xt_MARK usage problem
References: <Pine.LNX.4.61.0608220815560.24532@yvahk01.tjqt.qr> <44EAA447.1080004@trash.net> <Pine.LNX.4.61.0608220830110.24532@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608220830110.24532@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>How do I get MARK back to work in -t filter -- possibly without hacking in 
>>>xt_MARK.c?
>>
>>You won't, its not supposed to work in the filter table.
> 
> 
> This worked in 2.6.16, where the ipt_mark_reg_v1 strucutre in xt_MARK.c did 
> not have a .table limiter. (It also worked in practice, i.e. packets got 
> marked like they should.) I do not see why this was changed.


That is not true, all versions of the mark target starting in 2.4 had
the same check in the checkentry function.
