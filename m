Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTBXWV2>; Mon, 24 Feb 2003 17:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbTBXWV2>; Mon, 24 Feb 2003 17:21:28 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:1681 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261427AbTBXWV1>; Mon, 24 Feb 2003 17:21:27 -0500
Date: Mon, 24 Feb 2003 23:31:04 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Message-ID: <20030224223104.GB27579@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com> <jeznol5plv.fsf@sykes.suse.de> <20030224215335.GA24975@gtf.org> <jeu1et5o4i.fsf@sykes.suse.de> <20030224222144.GA27579@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030224222144.GA27579@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 February 2003 23:21:44 +0100, Jörn Engel wrote:
> 
> COUNT is constant and COUNT < INT_MAX. gcc can cast the constant bound
> to the variable's type to fix this problem.

Ok, Adrians example proved this approach stupid. But the one below
remains useful and catches one example, but not the other.

> Or, gcc can see that i starts with 0, it's value monotonously
> increases and will never wrap around due to COUNT < INT_MAX. Not a
> cheap test, but still possible.


Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
