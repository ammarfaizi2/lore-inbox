Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030740AbWJDSdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030740AbWJDSdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030742AbWJDSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:33:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:32446 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030740AbWJDSdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:33:32 -0400
Message-ID: <4523FE53.4030806@garzik.org>
Date: Wed, 04 Oct 2006 14:32:51 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linus Torvalds <torvalds@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
References: <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com>
In-Reply-To: <20061004181032.GA4272@bougret.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	You can't froze kernel userspace API forever. That is simply
> not workable, it will lead to stagnation and obsolescence. This is
> especially unfair because some other kernel userspace API are allow to
> change whenever their maintainers feels like.
> 
> 	Just to give you an example why we sometime need to
> change. The first two generations of 802.11 hardware were using the
> ESSID as a C-string (no NUL char), so the API was also using a
> C-string (no NUL char). New 802.11 hardware do accept NUL in the
> ESSID, therefore the API need to evolve away from C-string to offer
> this new feature to userspace. Especially that new WPA standard may
> use that in the future (cf. Jouni's e-mail).
> 
> 	In the past, kernel userspace API changes were done during the
> devel series, but we don't have this option anymore. What I would like
> people to discuss is what are the best practice to perform kernel
> userspace API changes in 2.6.X.

You can _add_ to the userspace API, because that obviously does not 
break old programs.

You just should not introduce changes which break old programs.

Binaries built in the 1990's still work under Linux, you know...

API changes require new ioctl/sub-ioctl numbers, so that new programs 
can take advantage of new capabilities while old programs continue to work.

	Jeff


