Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUADBMg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 20:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbUADBMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 20:12:36 -0500
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:20746
	"EHLO gateway.two14.net") by vger.kernel.org with ESMTP
	id S264286AbUADBMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 20:12:34 -0500
Date: Sat, 3 Jan 2004 19:12:22 -0600
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Maney <maney@two14.net>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20040104011222.GA1433@furrr.two14.net>
Reply-To: maney@pobox.com
References: <200310311941.31930.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310311941.31930.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Oct 31, 2003 at 07:52:21PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> [ http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/1164.html
>   for people seeing this subject for the first time ]

Sorry the reply is so belated, but by the time this patch came along I
was feeling like I had been more than a little foolish to test this on
a live (and very necessary) system as I had been doing.  I've finally
gotten hardware rearranged so that I can feel safe about this.

> Can you try booting with "hdX=autotune" (hdX==your drive) kernel parameter?

> The next thing to try is the attached patch (against 2.4.23-pre9), which
> sanitizes 66MHz clock usage -> now 66MHz clock is "enabled" before starting

Okay, by now I have 2.4.23 installed, and with that version (and booting
from a drive not connected to the Promise controller, a mirror pair on
a 3ware controller, in fact) I no longer seem to be able to recreate
the corruption that was previously so repeatable.  The autotune
parameter makes no difference: it just works.

If this issue is still of interest (ie, it's just by luck that .23
works), I can do further testing for a while, but the drive that's on
the Promise will be getting repurposed sooner or later.

-- 
Faced with the choice between changing one's mind and proving there is
no need to do so, almost everyone gets busy on the proof. -- JKG

