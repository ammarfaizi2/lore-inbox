Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBOSWV>; Thu, 15 Feb 2001 13:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRBOSWL>; Thu, 15 Feb 2001 13:22:11 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:63250 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129156AbRBOSV4>;
	Thu, 15 Feb 2001 13:21:56 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102151821.VAA19711@ms2.inr.ac.ru>
Subject: Re: MTU and 2.4.x kernel
To: roger@kea.GRace.CRi.NZ
Date: Thu, 15 Feb 2001 21:21:28 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102142039.PAA07913@whio.grace.cri.nz> from "roger@kea.GRace.CRi.NZ" at Feb 14, 1 11:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Kernel 2.4.x apparently disregards my ppp options MTU setting of 552
> and sets mss=536 (=> MTU=576).

Yes, default configuration is not allowed to advertise mss<536.
The limit is controlled via /proc/sys/net/ipv4/route/min_adv_mss,
you can change it to 256.

Default of 536 is sadistic (and apaprently will be changed eventually
to stop tears of poor people whose providers not only supply them
with bogus mtu values sort of 552 or even 296, but also jailed them
to some proxy or masquearding domain), but it is still right: IP
with mtu lower 576 is not full functional.

Alexey
