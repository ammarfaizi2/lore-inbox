Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVBGVLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVBGVLB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVBGVLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:11:01 -0500
Received: from relay.muni.cz ([147.251.4.35]:48556 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261285AbVBGVKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:10:54 -0500
Date: Mon, 7 Feb 2005 22:10:17 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: axboe@home.kernel.dk
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050207211017.GA19896@fi.muni.cz>
References: <20050121161959.GO3922@fi.muni.cz> <20050207110030.GI24513@fi.muni.cz> <Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org> <20050207155202.GY24513@fi.muni.cz> <56189.130.226.172.129.1107794295.squirrel@webmail.axboe.dk> <20050207173543.GD24513@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207173543.GD24513@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: 	I think I have been running 2.6.10-rc3 before. I've copied
: the fs/bio.c from 2.6.10-rc3 to my 2.6.11-rc2 sources and booted the
: resulting kernel. I hope it will not eat my filesystems :-) I will send
: my /proc/slabinfo in a few days.

	Hmm, after 3h35min of uptime I have

biovec-1           92157  92250     16  225    1 : tunables  120   60    8 : slabdata    410    410     60
bio                92163  92163    128   31    1 : tunables  120   60    8 : slabdata   2973   2973     60

so it is probably still leaking - about half an hour ago it was

biovec-1           77685  77850     16  225    1 : tunables  120   60    8 : slabdata    346    346      0
bio                77841  77841    128   31    1 : tunables  120   60    8 : slabdata   2511   2511    180

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
