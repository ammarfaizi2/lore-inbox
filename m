Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277938AbRJOTiR>; Mon, 15 Oct 2001 15:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278052AbRJOTiG>; Mon, 15 Oct 2001 15:38:06 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:24960 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S277938AbRJOThr>; Mon, 15 Oct 2001 15:37:47 -0400
Message-ID: <3BCB3B1A.B524A605@welho.com>
Date: Mon, 15 Oct 2001 22:38:02 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru, ak@muc.de, davem@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <200110151840.WAA24000@ms2.inr.ac.ru> <3BCB35CA.4D9D2952@welho.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Liljeberg wrote:
> Anyway, it would be interesting to try a (even more) relaxed version of
> Nagle that would allow a maximum of two remnants in flight. This would
> basically cover all TCP request/reply cases (leading AND trailing
> remnant). Coupled with large initial window to get rid of  small-cwnd
> interactions, it might be almost be all right.

Oops, bad idea. You can quench the objections, I already figured out it
won't work. :-(

I guess we're stuck with the current status quo: braindead application
protocols will perform badly no matter what we do. All we can really do
is prevent them harming the network.

Regards,

	MikaL
