Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314420AbSESO4P>; Sun, 19 May 2002 10:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSESO4O>; Sun, 19 May 2002 10:56:14 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:677 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S314420AbSESO4O>;
	Sun, 19 May 2002 10:56:14 -0400
Date: Sun, 19 May 2002 10:56:14 -0400
From: Jeff Garzik <garzik@gtf.org>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        casdcsdc sdfccsdcsd <computrius@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: davicom 9102 and linux 2.5
Message-ID: <20020519105614.A10528@gtf.org>
In-Reply-To: <20020518181821.GA3683@conectiva.com.br> <Pine.LNX.4.44.0205191056070.31419-100000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 11:06:30AM +0200, Tobias Ringstrom wrote:
> Jeff, would you care to enlighten us as to why this was done?  To educate
> users that the Davicom chip is really a (bad) tulip clone?

The move was mainly motivated by long term programmer direction, not a
Config.in user interface change (which in hindsight could have been
done better).

Davicom and other tulip-related files are being organized into
drivers/net/tulip, and eventually they will be sharing code from a
tulip_lib.c file or similar.

My long term idea is to have a shared lib providing the core for drivers
which support:
21040/1 chips
21140/2/3 chips
Xircom chips
...and then all other tulip clones will probably be rolled into a
"tulip_clone.c".

i.e. organize the tulip chips into major families, with a central
tulip_lib.c from which they all share code.

	Jeff



