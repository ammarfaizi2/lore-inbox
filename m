Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292662AbSCFAyE>; Tue, 5 Mar 2002 19:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSCFAxz>; Tue, 5 Mar 2002 19:53:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29963 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292583AbSCFAxm>; Tue, 5 Mar 2002 19:53:42 -0500
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Wed, 6 Mar 2002 01:08:38 +0000 (GMT)
Cc: arjanv@redhat.com (Arjan van de Ven),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020305221933.A405@ucw.cz> from "Vojtech Pavlik" at Mar 05, 2002 10:19:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iPv4-00052k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that taskfiles are not being removed from IDE. Just direct (and
> parsed and filtered) interface to userspace. Does the scsi midlayer
> export the SCBs directly to userspace?

Yes. And whats more the scsi generic layer has a hell of a lot less ioctls
than IDE because of that. With something like scsi enclosure, scsi smart,
scsi scanners its a godsend to be able to just say "Ok OS take a hike, I
wish to chat with this device exactly as I damn well please".

[Reminds me - anyone got any Linux enclosure monitoring code ?]
