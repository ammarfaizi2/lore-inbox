Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbSJaLhk>; Thu, 31 Oct 2002 06:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264859AbSJaLhk>; Thu, 31 Oct 2002 06:37:40 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:62985 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S264860AbSJaLhj>; Thu, 31 Oct 2002 06:37:39 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200210311136.g9VBaKBi013883@wildsau.idv.uni.linz.at>
Subject: Re: VIA EPIA problem
In-Reply-To: <20021031100245.GA5207@k3.hellgate.ch> from Roger Luethi at "Oct 31, 2 11:02:45 am"
To: rl@hellgate.ch (Roger Luethi)
Date: Thu, 31 Oct 2002 12:36:20 +0100 (MET)
Cc: kernel@wildsau.idv.uni.linz.at, alan@lxorguk.ukuu.org.uk,
       sergeyssv@mail.ru, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> My favorite suspect is currently byte 84 bit 3 in the configuration
> registers. It does not exist in VT86C100A (which would explain why it's not
> handled in Donald Becker's original code). According to VT6102 specs, it
> indicates an error condition, according to VT6105 specs, it is reserved and
> always reads 0.

okay, let's reopen the case. you want me to monitor this bit? perhaps
it will be 1 in case of an error condition. for the via epia board, this
would contradict with the specs, right? but *maybe* the bit is indeed
1 in case of an error, so we could possibly fix the problem just in time,
instead of (ugly) storing some temporary value globally across functions.



