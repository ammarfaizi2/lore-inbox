Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270646AbTG0Bqh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 21:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270647AbTG0Bqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 21:46:37 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:48268
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270646AbTG0Bqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 21:46:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: WINE + Galciv + Con Kolivar's 09 patch to  2.6.0-test1-mm2
Date: Sun, 27 Jul 2003 12:05:59 +1000
User-Agent: KMail/1.5.2
References: <3F22F75D.8090607@rogers.com>
In-Reply-To: <3F22F75D.8090607@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271205.59230.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 07:49, gaxt wrote:
> Kudos to CK

Thanks.

> In 2.4.21 galciv + wine was fine.
>
> In 2.4.21 + CK patches, galvic + wine would pause every 15 seconds or so
> (maybe it was when little animations played).
>
> In 2.6.0-test1-mm2 (vanilla, or + 08) Galciv would stutter horribly and
> freeze my machine in wine. It might run smoothly until I loaded a
> nautilus window or something then stutters and loss of control of the
> system.
>
> With 09, it is smooth as silk until I do something and then the video
> playbacks can be choppy but the game (turn based strategy) seems to run
> without the long pauses of 2.4.21 CK or 2.6.0 vanilla. I can switch
> between apps and go back without any problem.
>
> 09 seems to be a big improvement for whatever caused the stutter & die
> problems in wine+galciv.

Therein lies the problem with large MAX_SLEEP_AVG values. It may prevent 
interactive tasks from becoming non interactive (which is the point), but if 
an interactive task turns into a true cpu hog it can literally stall the 
machine for seconds. Which is why the workaround in O*int that allow small 
MSAs help.

Con

