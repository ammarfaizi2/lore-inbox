Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVAQUkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVAQUkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVAQUkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:40:20 -0500
Received: from terminus.zytor.com ([209.128.68.124]:55001 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262878AbVAQUkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:40:00 -0500
Message-ID: <41EC224D.5080204@zytor.com>
Date: Mon, 17 Jan 2005 12:38:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Arjan van de Ven <arjan@infradead.org>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>	<20050114205651.GE17263@kam.mff.cuni.cz>	<Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>	<cs9v6f$3tj$1@terminus.zytor.com>	<Pine.LNX.4.61.0501170909040.4593@ezer.homenet>	<1105955608.6304.60.camel@laptopd505.fenrus.org>	<Pine.LNX.4.61.0501171002190.4644@ezer.homenet>	<41EBFF87.6080105@zytor.com> <m1wtubvm8y.fsf@muc.de>
In-Reply-To: <m1wtubvm8y.fsf@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> To be fair there isn't a nice library for it on x86-64.  There
> is libunwind on IA64, but afaik nobody ported it to x86-64 yet.
> 
> Just various projects have their own private unwind
> implementation. The kernel including KDB has always lived with
> imprecise backtraces and no argument printing. I don't think it has
> been a show stopper so far.  If you really want the arguments you can
> always use kgdb.
> 
> However I'm not sure we really want libunwind in the kernel anyways
> (not even in KDB ;-) If anything better something stripped down and 
> simple which libunwind isn't.
> 
> Unfortunately dwarf2 is not exactly a simple spec so implementing
> a new backtracer for the kernel is not a trivial task. 
> 

Seems like the unwinder should be running client-side, like it does on 
kgdb.  Or does kdb not have a client at all?  (If so, I have no sympathy 
for it.)

	-hpa

