Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272766AbRILMqO>; Wed, 12 Sep 2001 08:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272767AbRILMqF>; Wed, 12 Sep 2001 08:46:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272766AbRILMpy>; Wed, 12 Sep 2001 08:45:54 -0400
Subject: Re: Duron kernel crash (i686 works)
To: VDA@port.imtp.ilyichevsk.odessa.ua
Date: Wed, 12 Sep 2001 13:48:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1715812347.20010912140853@port.imtp.ilyichevsk.odessa.ua> from "VDA" at Sep 12, 2001 02:08:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15h9RE-0004Qe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So why it is oopses then?

On correct hardware it doesnt seem to oops. 

> Also, we don't want this data to arrive late or whatever.
> fast_copy_page must copy page (make it so that memcpy()==0).
> If it does not, it is too much "optimized".

See the "sfence" instruction

> A better way to do it is to bencmark several routines at
> startup time and pick the best one. It is done now
> for RAID xor'ing routine.

Not in this case. It is Athlon specific code. It was fine tuned when it
was written
