Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284882AbRLFAN2>; Wed, 5 Dec 2001 19:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284885AbRLFANT>; Wed, 5 Dec 2001 19:13:19 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39869 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S284882AbRLFANF>; Wed, 5 Dec 2001 19:13:05 -0500
Date: Thu, 6 Dec 2001 09:12:45 +0900
Message-Id: <200112060012.JAA04482@asami.proc.flab.fujitsu.co.jp>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct + kernel stack colouring ...
In-Reply-To: <3C0E84B4.1070808@colorfullife.com>
In-Reply-To: <Pine.LNX.4.40.0112051103100.1644-100000@blue1.dev.mcafeelabs.com>
	<3C0E84B4.1070808@colorfullife.com>
Reply-To: kumon@flab.fujitsu.co.jp
From: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul writes:
 > Shuij, I don't understand why you need both a shift and a modulo: 
 > address % odd_number should generate a random distribution (i.e. all 
 > bits affect the result), even without the shift.

The lame duck reason was: previously it was intended to use within
Current macro, the division should be avoided such a frequently used
operation.

Currently the stack coloring operation is required only at process
creation time, division by a odd number is sufficient and we'll
experiment it.
--
Kouichi Kumon, Software Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
