Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSE0G1j>; Mon, 27 May 2002 02:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314404AbSE0G1i>; Mon, 27 May 2002 02:27:38 -0400
Received: from goliath.siemens.de ([192.35.17.28]:61594 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S314381AbSE0G1i>; Mon, 27 May 2002 02:27:38 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'David Brownell'" <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: RE: ehci-hcd on CARDBUS hangs when stopping card service
Date: Mon, 27 May 2002 10:27:30 +0400
Message-ID: <6134254DE87BD411908B00A0C99B044F02E89AF7@mowd019a.mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <3CED6E0B.8020501@pacbell.net>
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[I should have mentioned I am not on lkml; as it stands now I reply to
thread off web archive]

It looks like discussion is focused on a problem how to detect a removed
card. While this problem definitely exists - I'd like to stress that the
original report was about a normal shutdown case. Just do init 0 with
card plugged in and system hangs. IMHO that should be dealt with in the
first place.

As for general case, I do not know hardware well enough. If as mentioned
some architectures have a general problem accessing removed devices then
CardBus driver should not call normal cleanup sequence in this case and
just signal abort condition to a low level driver (so that any in-memory
structures may be removed without an attempt to actually touch
hardware). 

Regards

-andrej

P.S. I would appreciate Cc to me. Thank you.
