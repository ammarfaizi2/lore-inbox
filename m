Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbUJ1Pcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUJ1Pcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUJ1Pav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:30:51 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:7879 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261729AbUJ1PZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:25:42 -0400
Message-ID: <41810FAB.40107@metaparadigm.com>
Date: Thu, 28 Oct 2004 23:26:35 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 page allocation failure. order:0, mode:0x20
References: <41808419.8070104@metaparadigm.com> <200410281129.09810.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410281129.09810.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/04 16:29, Denis Vlasenko wrote:
> On Thursday 28 October 2004 08:31, Michael Clark wrote:
> 
>>BTW - 2.6 is much more responsive than 2.4 while this is all
>>going on - i'm just worried about these messages.
> 
> 
> Which one was faster, and by how much?

Both tests compiling 2.6.9 tree with make -j192 bzImage modules
(.config posted earlier) from clean source after a reboot.
2CPUs, 2GB RAM, 2GB swap

2.4.27
real    15m38.504s
user    21m5.720s
sys     3m28.990s
peaked at about 1.7GB swap usage

2.6.9
real    14m50.360s
user    21m9.008s
sys     2m40.580s
peaked at 2.0GB swap usage - top said 0K swap free and it survived ;)

2.6.9 was 5% faster (although subjectively almost a magnitude more
responsive ie. sshing into the box in the middle of this took
about a minute with 2.4.27 and only about 10 or so seconds with 2.6.9,
although i didn't time this).

Seems 2.6's more proactive swapping helps a bit ie. swap more of
the right stuff so as to swap less overall as 2.6 went about 20%
deeper into swap.

~mc
