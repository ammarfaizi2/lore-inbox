Return-Path: <linux-kernel-owner+w=401wt.eu-S936250AbWLIONY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936250AbWLIONY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936275AbWLIONY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:13:24 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:39409 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936250AbWLIONX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:13:23 -0500
Date: Sat, 9 Dec 2006 15:11:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Ian E. Morgan" <penguin.wrangler@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: Loud POP from sound system during module init w/ 2.6.19
In-Reply-To: <2a6e8c0d0612090517j5afe2161p591203c70ddfc890@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612091511111.8055@yvahk01.tjqt.qr>
References: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com> 
 <Pine.LNX.4.61.0612091020450.8055@yvahk01.tjqt.qr>
 <2a6e8c0d0612090517j5afe2161p591203c70ddfc890@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 9 2006 08:17, Ian E. Morgan wrote:
>
> Previous kernel was 2.6.18.3, which did not exhibit the problem. I was
> aware of udev setting the mixer at module load time, but I disabled
> that and the problem still exists.

Another reason might be that the sound driver sets the initial volume 
(even before udev can act) to 100%. That's probably Not So Good.
I'd suggest to take a diff between 2.6.18.3's sound tree and the 2.6.19 
one, and see if the driver for your card changed.


	-`J'
-- 
