Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUACKyr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 05:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbUACKyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 05:54:47 -0500
Received: from lmdeliver02.st1.spray.net ([212.78.202.115]:49037 "EHLO
	lmdeliver02.st1.spray.net") by vger.kernel.org with ESMTP
	id S262731AbUACKyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 05:54:45 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Valdis.Kletnieks@vt.edu
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Sat, 3 Jan 2004 11:20:07 +0100
User-Agent: KMail/1.5.2
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <200401022200.22917.ornati@lycos.it> <200401022127.i02LR0vm015416@turing-police.cc.vt.edu>
In-Reply-To: <200401022127.i02LR0vm015416@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401031119.31554.ornati@lycos.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 January 2004 22:27, you wrote:
>
> Do you get different numbers if you boot with:
>
> elevator=as
> elevator=deadline
> elevator=cfq  (for -mm kernels)
> elevator=noop
>

Changing io scheduler doesn't seem to affect performance too much...

AS (the one already used)
> > 2.6.0:
> > 64        31.91
> > 128      31.89
> > 256      26.22	# during the transfer HD LED blinks
> > 8192    26.26	# during the transfer HD LED blinks
> >
> > 2.6.1-rc1:
> > 64        25.84	# during the transfer HD LED blinks
> > 128      25.85	# during the transfer HD LED blinks
> > 256      25.90	# during the transfer HD LED blinks
> > 8192    26.42	# during the transfer HD LED blinks

DEADLINE
2.6.0:
64	31.89
128	31.90
256	26.18
8192	26.22

2.6.1-rc1:
64	25.90
128	26.14
256	26.06
8192	26.45

NOOP
2.6.0:
64	31.90
128	31.76
256	26.05
8192	26.20

2.6.1-rc1:
64	25.91
128	26.23
256	26.16
8192	26.40


Bye

-- 
	Paolo Ornati
	Linux v2.4.23

