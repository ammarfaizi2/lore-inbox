Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275685AbRIZXGc>; Wed, 26 Sep 2001 19:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275687AbRIZXGW>; Wed, 26 Sep 2001 19:06:22 -0400
Received: from hermes.domdv.de ([193.102.202.1]:26884 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S275685AbRIZXGJ>;
	Wed, 26 Sep 2001 19:06:09 -0400
Message-ID: <XFMail.20010927010603.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010926155522.C4828@furble>
Date: Thu, 27 Sep 2001 01:06:03 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In any case the following must be true for this to cause problems:
>    a) The network must be the primary source of entropy (this
>       will be common in the case where the patch is useful)
>    b) BadGuy must monitor from time 0 (boot of system) to get
>       useful information
>    c) BadGuy must have information about what network card the system
>       has, or _very_ good statistical information about delay to
>       interrupt & timing in general.
>    d) BadGuy must have information about how long the processing for
>       the interrupt handler takes, as the randomness addition is done
>       _after_ all processing. This also causes interesting problems
>       for prediction if more than one event is handled at once.
>    e) BadGuy must have access to information of network traffic on
>       all the networks that are attached to the computer.
> 
> Now none of this guarantees security (but then again, very little will
> _guarantee_ security.
> 
> I may have missed some stuff here... (caveat emptor)
> 

To be constructive: why not make this HMAC-SHA1? The key for HMAC can be fed
through a sysctl interface. This would mean that BadGuy would need knowledge of
the key and thus the key generation method, too, especially if the key is
replaced at varying times and independent of network traffic.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
