Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261602AbSIXHeT>; Tue, 24 Sep 2002 03:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261603AbSIXHeS>; Tue, 24 Sep 2002 03:34:18 -0400
Received: from AMarseille-201-1-5-7.abo.wanadoo.fr ([217.128.250.7]:1904 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S261602AbSIXHeS>;
	Tue, 24 Sep 2002 03:34:18 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20pre7, aic7xxx-6.2.8: Panic: HOST_MSG_LOOP with invalid
 SCB 0
Date: Mon, 23 Sep 2002 09:15:42 +0200
Message-Id: <20020923071542.32214@192.168.4.1>
In-Reply-To: <2632550816.1032817396@aslan.btc.adaptec.com>
References: <2632550816.1032817396@aslan.btc.adaptec.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No, it is not write posting.  It is usually a problem with write
>combining/merging and or read prefetch on devices that do not
>support this feature.  The memory BAR on the aic7xxx chips does
>not have the PREFETCH bit set so these types of operations are
>forbidden by the spec.  The end result are missed writes and
>state read data leading to all kinds of driver confusion.
>
>Often these issues are really register layout dependent.  If
>you never have to access two registers that are right next to
>each other, the chipset can't write combine, etc.

Ok, well. Indeed, adding a read on all writes may help here.
Does this affect the performances significantly ?

Ben.


