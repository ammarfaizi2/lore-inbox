Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132555AbRDNVni>; Sat, 14 Apr 2001 17:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132551AbRDNVn2>; Sat, 14 Apr 2001 17:43:28 -0400
Received: from colorfullife.com ([216.156.138.34]:26373 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132555AbRDNVnR>;
	Sat, 14 Apr 2001 17:43:17 -0400
Message-ID: <001b01c0c52c$03070b00$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Rod Stewart" <stewart@dystopia.lab43.org>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E14oVAp-0005Nj-00@the-village.bc.nu>
Subject: Re: [PATCH] Re: 8139too: defunct threads
Date: Sat, 14 Apr 2001 23:43:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
>
> That has an implicit race, a zombie can always appear as we are
execing init.
> I think init wants fixing
>
Rod, could you boot again with the unpatched kernel and send a sigchild
to init?

#kill -CHLD 1

If I understand the init code correctly the sigchild handler reaps all
zombies, but probably the signal got lost because the children died
before the parent was created ;-)

--
    Manfred

