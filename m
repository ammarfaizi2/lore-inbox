Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVBGRhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVBGRhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVBGRg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:36:56 -0500
Received: from relay.muni.cz ([147.251.4.35]:32990 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261233AbVBGRgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:36:24 -0500
Date: Mon, 7 Feb 2005 18:35:43 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: axboe@home.kernel.dk
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050207173543.GD24513@fi.muni.cz>
References: <20050121161959.GO3922@fi.muni.cz> <20050207110030.GI24513@fi.muni.cz> <Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org> <20050207155202.GY24513@fi.muni.cz> <56189.130.226.172.129.1107794295.squirrel@webmail.axboe.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56189.130.226.172.129.1107794295.squirrel@webmail.axboe.dk>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axboe@home.kernel.dk wrote:
: My guess would be the clone change, if raid was not leaking before. I
: cannot lookup any patches at the moment, as I'm still at the hospital
: taking care of my new born baby and wife :)

	Congratulations!

: But try and reverse the patches to fs/bio.c that mention corruption due to
: bio_clone and bio->bi_io_vec and see if that cures it. If it does, I know
: where to look. When did you notice this started to leak?

	I think I have been running 2.6.10-rc3 before. I've copied
the fs/bio.c from 2.6.10-rc3 to my 2.6.11-rc2 sources and booted the
resulting kernel. I hope it will not eat my filesystems :-) I will send
my /proc/slabinfo in a few days.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
