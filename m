Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbVKDJmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbVKDJmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 04:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbVKDJmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 04:42:09 -0500
Received: from [213.91.10.50] ([213.91.10.50]:45513 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S932718AbVKDJmI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 04:42:08 -0500
X-DomainKeys: Sendmail DomainKeys Filter v0.3.0 zone4.gcu-squad.org jA49TZNC006848
X-DKIM: Sendmail DKIM Filter v0.1.1 zone4.gcu-squad.org jA49TZNC006848
Date: Fri, 4 Nov 2005 10:29:34 +0100 (CET)
To: matti.aarnio@zmailer.org
Subject: Re: I2C regression in post 2.6.14 gits..
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <Go3tHv2d.1131096574.7056520.khali@localhost>
In-Reply-To: <20051102223818.GE3423@mea-ext.zmailer.org>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.1 (zone4.gcu-squad.org [127.0.0.1]); Fri, 04 Nov 2005 10:29:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matti,

On 2005-11-04, Matti Aarnio wrote:
> Specifically,  BTTV driver fails to control internal
> I2C devices in Hauppauge WinTV card with Bt848 onboard.

Can you detail how you came up with this diagnosis?

> Baseline 2.6.14 works fine,  but 2.6.14-git2 fails.

Can you please try 2.6.14-git1 and 2.6.14-rc5-mm1? This should help us
norrow the faulty patch. Also, please confirm that 2.6.14-git7 still has
the problem.

> Any ideas ?  Possible fixes ?

Enable as many debugging as possible, in particular I2C Core debugging
(I2C_DEBUG_CORE=y) in a working kernel and a non-working kernel, and
send both logs for comparison.

Thanks a lot for testing, BTW.

--
Jean Delvare
