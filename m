Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVCLUpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVCLUpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 15:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVCLUpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 15:45:12 -0500
Received: from port-212-202-144-146.static.qsc.de ([212.202.144.146]:56553
	"EHLO mail.hennerich.de") by vger.kernel.org with ESMTP
	id S261241AbVCLUpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 15:45:06 -0500
Date: Sat, 12 Mar 2005 21:42:17 +0100
From: Tobias Hennerich <Tobias@Hennerich.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Strange memory leak in 2.6.x
Message-ID: <20050312214216.A24046@bart.hennerich.de>
References: <20050308133735.A13586@bart.hennerich.de> <20050308173811.0cd767c3.akpm@osdl.org> <20050309102740.D3382@bart.hennerich.de> <20050311183207.A22397@bart.hennerich.de> <1110565420.2501.12.camel@boxen> <20050312133241.A11469@bart.hennerich.de> <1110640085.2376.22.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1110640085.2376.22.camel@boxen>; from alexn@dsv.su.se on Sat, Mar 12, 2005 at 04:08:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rehi Alexander,

On Sat, Mar 12, 2005 at 04:08:05PM +0100, Alexander Nyberg wrote:
> The next one here is how it looks when it is not so good:
> [0xc013962b] find_or_create_page+91
> [0xc01596ac] grow_dev_page+44
> [0xc015986a] __getblk_slow+170
> [0xc0159c26] __getblk+54
> [0xf8ac0a57] +1207
> [0xf8abfccd] +61
> [0xf8ac03c1] +241
> [0xf8ac040a] +42
> 
> Stupid me, the 0xf8ac040a addresses are vmalloc space (modules). I need
> to look into why it doesn't work with vmalloc but in the meantime, could
> you please save a copy of /proc/kallsyms from the computer right away so
> that I can look up those when the computer locks up (the copy needs to
> be from the current run, addresses can change between reboots).

See http://download.hennerich.de/kallsyms_20050312_1630.gz

> Thanks for helping to track this down.

Thanks for your support - even on Saturday! 8-)

Best regards	Tobias Hennerich

-- 
T+T Hennerich GmbH --- Zettachring 12a --- 70567 Stuttgart
Fon:+49(711)720714-0  Fax:+49(711)720714-44  Vanity:+49(700)HENNERICH
UNIX - Linux - Java - C  Entwicklung/Beratung/Betreuung/Schulung
http://www.hennerich.de/
