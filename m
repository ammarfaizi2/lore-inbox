Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUGZWuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUGZWuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUGZWuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:50:19 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:24484 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266157AbUGZWuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:50:13 -0400
Date: Tue, 27 Jul 2004 00:50:09 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: no luck with max_sectors_kb (Re: voluntary-preempt-2.6.8-rc2-J4)
Message-ID: <20040726225009.GA2369@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040726101536.GA29408@elte.hu> <20040726204228.GA1231@ss1000.ms.mff.cuni.cz> <20040726205741.GA27527@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726205741.GA27527@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After setting it to 32 (the hw max is 128), userland programs fail
> > with I/O errors. Setting it back to 128 gets it back to working, sort
> > of. The errors probably get bufferred somewhere.
> > 
> > During the "bad" setting (32), messages like this one show up in kernel log.
> > 
> > bio too big device hda3 (104 > 64)
> 
> does the patch below, ontop of -J7, help?

I tried it, but did not test tuning the value, as the patch has problems of its
own: with device-mapper.

bio too big device dm-0 (256 > 255)

Again, some files cannot be read on the device.

Bye for now.

Rudo.
