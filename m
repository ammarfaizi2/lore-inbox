Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269277AbUI3OG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269277AbUI3OG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUI3OG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:06:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48785 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269277AbUI3OGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:06:51 -0400
Date: Thu, 30 Sep 2004 15:04:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Stefan Seyfried <seife@suse.de>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: mlock(1)
Message-ID: <20040930130418.GI2692@openzaurus.ucw.cz>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de> <20040927141652.GF28865@dualathlon.random> <4158250E.9020005@suse.de> <20040927150702.GI28865@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927150702.GI28865@dualathlon.random>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That's fine for the never-enter-a-password case, but for the 
> > suspend-case, it's not so good since i want to close the lid and pack 
> > away the notebook. Two scenarios, two implementations.
> 
> Your "close-lid with suspend-to-disk" without ever asking password in
> suspend is fundamentally unfixable, unless you use public key
> encryption, but for it to be secure you've to store in your brain and
> type >128 chars at every resume...

?? You can store private key on harddrive and encrypt it by
symmetric crypto. No need for that huge passphrases.

> But it's not secure anyways without encryption since the memory freed by
> mozilla where the credit card was, could be dumped into the swap space
> if it was only partially reused as slab etc.. I mean, even normal
> swapping is insecure on a laptop, but suspend make it worse.

I believe this should be fixed, first. Then we can work on suspend/resume...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

