Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbSASQTG>; Sat, 19 Jan 2002 11:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSASQS4>; Sat, 19 Jan 2002 11:18:56 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:18671 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S285828AbSASQSu>; Sat, 19 Jan 2002 11:18:50 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>,
        Lukas Geyer <geyer@ml.kva.se>
Subject: Re: 2.4.18pre4 on PPC, Byteswap in dmasound_awacs.c
Date: Sat, 19 Jan 2002 17:18:19 +0100
Message-Id: <20020119161819.5536@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0201191547510.6868-100000@cauchy.ml.kva.se>
In-Reply-To: <Pine.LNX.4.33.0201191547510.6868-100000@cauchy.ml.kva.se>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>My Keylargo controller reports 0 as the revision number, thus it might
>either be advisable to put that hw_can_byteswap = 0 into the innermost
>block and not check the revision at all (if no Keylargo can do byteswap)
>or or to put a check for revision <= 2 (after all, isn't it logical to
>assume that only later revisions will be able to do byteswap?) inside the
>innermost block and set hw_can_byteswap to 0 there.

You are right, this is a pangea chipset (KeyLargo & UniNorth in a
single ASIC) and in that case, KL provides no rev. number. I'll fix
this.

Thanks for the report,
Ben.


