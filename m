Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272313AbTHRTtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272445AbTHRTtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:49:21 -0400
Received: from mail.cid.net ([193.41.144.34]:52902 "EHLO mail.cid.net")
	by vger.kernel.org with ESMTP id S272313AbTHRTtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:49:20 -0400
Date: Mon, 18 Aug 2003 21:49:02 +0200
From: Stefan Foerster <stefan@stefan-foerster.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very bad interactivity with 2.6.0 and SCSI disks (aic7xxx)
Message-ID: <20030818194902.GB1589@in-ws-001.cid-net.de>
References: <20030818013243.GB21665@in-ws-001.cid-net.de> <1294265408.1061233452@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1294265408.1061233452@aslan.btc.adaptec.com>
X-Now-Playing: Sting - Desert Rose
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* "Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>> But as soon as I do a
>> 
>> while true; do dd if=/dev/zero of=test bs=1024 count=1048576 ; rm test
>> ; done
>> 
>> on my SCSI disk, the system becomes completely unusuable after a few
>> seconds. Everything is running at the speed of molasses, even screen
>> redrawing, the music stops playing for some seconds, my mouse hangs
>> and so on.
> 
> It sounds like the system is not limiting the rate at which an I/O
> hog can dirty pages, so this one process ends up consuming all of
> your I/O bandwidth.

Well, this is not the desired behaviour, at least not for me. Any
ideas what I could do to solve this problem? I sent an oprofile output
to lkml, perhaps that helps?

I am more than willing to give every information needed to debug this
problem, because this bad interactive behaviuor is really annoying.

Is there a slight possibility that this problem is not specific to
2.5/2.6, because I encounter similar problems on 2.4?


Ciao,
Stefan
-- 
Stefan Förster                                  Public Key: 0xBBE2A9E9
FdI #192: Strong international Encryption - Triple-ROT13 (Carsten Lechte)

