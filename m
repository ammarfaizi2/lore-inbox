Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSENRrg>; Tue, 14 May 2002 13:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315927AbSENRrf>; Tue, 14 May 2002 13:47:35 -0400
Received: from fungus.teststation.com ([212.32.186.211]:33810 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S315926AbSENRrd>; Tue, 14 May 2002 13:47:33 -0400
Date: Tue, 14 May 2002 19:47:02 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Roger Luethi <rl@hellgate.ch>
cc: "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VIA Rhine stalls: TxAbort handling
In-Reply-To: <20020514035318.GA20088@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.33.0205141928410.20379-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Roger Luethi wrote:

> The simple reason: The AMD backoff algorithm always triggered TxAborts,
> the others didn't.
> 
> However, once I had the driver recover from TxAbort without waiting for the
> time out reset, the AMD solution provided over 20% higher throughput than
> the DEC algorithm. YMMV, depending on the specific setup. I'd vote for a
> module parameter. For now, I hardcoded AMD: it's what the eeprom picks when
> reloaded. Also, every other algorithm masked the TxAbort problem (by not
> triggering any).

The backoff algorithm bits have different names (and possibly different
meaning) for the vt86c100a. My vt86c100a eeprom sets all backoff bits to
0000, but my vt6102 sets it to 0010. Since the eeprom is reloaded when the
driver opens, why force it to "amd"?

A module parameter would be nice for testing.

Ivan, have you tried playing with these bits?

Donalds suggestion is that the TxAborts is simply too much collisions.
Perhaps the eeprom selection of backoff algorithm isn't working well in
your environment.

/Urban

