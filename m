Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274493AbRITNlH>; Thu, 20 Sep 2001 09:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274494AbRITNk5>; Thu, 20 Sep 2001 09:40:57 -0400
Received: from mail.scs.ch ([212.254.229.5]:21003 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S274493AbRITNkr>;
	Thu, 20 Sep 2001 09:40:47 -0400
Message-ID: <3BA9F1F0.F9FAD38B@scs.ch>
Date: Thu, 20 Sep 2001 15:41:04 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.3-13jnx i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
CC: Nicholas Knight <tegeran@home.com>, Adrian Cox <adrian@humboldt.co.uk>,
        t.sailer@alumni.ethz.ch, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio locking problems
In-Reply-To: <3BA9AB43.C26366BF@scs.ch> <01092004333500.00182@c779218-a> <3BA9DBED.9020401@humboldt.co.uk> <01092005243800.01369@c779218-a> <20010920154049.A4282@telia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

André Dahlqvist schrieb:

> I'm  using the VIA audio driver and I have what appears to be a very similar
> problem:
> 
> When I try to move my XMMS window while playing a song the window sometimes
> "gets stuck" for a second or so during the move. Moving the window without
> any song playing works just fine. I also tried setting the buffer to 200ms
> but it didn't solve it for me either.

I'm seeing this too. XMMS polls the mixer every couple of seconds,
and runs into the semaphore locking issue. As to why moving windows
in that state is blocked I don't know since I do not know the X internals
well enough...

Tom
