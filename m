Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSLaS7t>; Tue, 31 Dec 2002 13:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSLaS7t>; Tue, 31 Dec 2002 13:59:49 -0500
Received: from main.gmane.org ([80.91.224.249]:50849 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S264706AbSLaS7s>;
	Tue, 31 Dec 2002 13:59:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Jason Lunz <lunz@falooley.org>
Subject: Re: NIC with polling support
Date: Tue, 31 Dec 2002 19:07:21 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb13qop.bsm.lunz@stoli.localnet>
References: <87el7yrvso.fsf@Login.CERT.Uni-Stuttgart.DE>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Weimer@CERT.Uni-Stuttgart.DE said:
> Any suggestions which card I should use?  The driver has to be open
> source, and the card shouldn't be too expensive (i.e. in the usual
> price range of brand 100BaseTX NICs).

linux 2.4.20 supports NAPI for tg3 only. I have patches for e1000,
3c59x, tulip, and eepro100 at:

	http://gtf.org/lunz/linux/net/

The tulip patch might be a bit outdated. The only one of these patches
that I've personally tested extensively is e1000, and it works well
under extremely high interrupt load. e1000 cards are getting cheap
enough to be considered as 100BaseTX NICs, and they perform well doing
that.

Napi patches also exist for dl2k and a few other drivers, but I'm not
sure where.

Jason


