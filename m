Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTGOGkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTGOGkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:40:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59526 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263542AbTGOGkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:40:11 -0400
Date: Tue, 15 Jul 2003 08:54:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jiho@c-zone.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: IDE driver:  CBLID revisited
Message-ID: <20030715065450.GE27368@ucw.cz>
References: <3F0A2129.5070705@c-zone.net> <3F133E61.1050705@c-zone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F133E61.1050705@c-zone.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 04:36:01PM -0700, jiho@c-zone.net wrote:

> The first test checks the cable type bit, then if that fails the rest 
> checks UDMA enabled with mode timing for UDMA-66 or better.
> 
> But the last test, (((u >> i) & 7) < 8)), should have  < 6.

Indeed, since 6 means (6+2)*7.5ns which is 60ns, which is the correct
threshold. I probably forgot to subtract the '2' ...

Please can you make patches for 2.4 and 2.6?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
