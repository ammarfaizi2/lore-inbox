Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUEASis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUEASis (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 14:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUEASis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 14:38:48 -0400
Received: from ns.suse.de ([195.135.220.2]:36056 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261673AbUEASiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 14:38:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Gerd Knorr <kraxel@bytesex.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: gcc 2.95: cx88 __ucmpdi2 error
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au> <20040501112432.GE2541@fs.tum.de>
	<Pine.LNX.4.58.0405011025410.18014@ppc970.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: LOOK!!  Sullen American teens wearing MADRAS shorts and
 ``Flock of Seagulls'' HAIRCUTS!
Date: Sat, 01 May 2004 20:38:15 +0200
In-Reply-To: <Pine.LNX.4.58.0405011025410.18014@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 1 May 2004 10:45:36 -0700 (PDT)")
Message-ID: <jey8oc6lig.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 1 May 2004, Adrian Bunk wrote:
>> >...
>> > WARNING: /lib/modules/2.6.6-rc3/kernel/drivers/media/video/cx88/cx8800.ko 
>> > needs unknown symbol __ucmpdi2
>> 
>> I'm also seeing this, but only with gcc 2.95, not with gcc 3.3.3 .
>> 
>> It comes from drivers/media/video/cx88/cx88-video.c, more exactly from 
>> the switch in set_tvaudio.
>
> I don't see that set_tvaudio() uses any 64-bit comparisons at all, so I 
> have this suspicion that the linker reports the wrong function or 
> something. 

dev->tvnorm->id is __u64.

linux/videodev2.h:typedef __u64 v4l2_std_id;

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
