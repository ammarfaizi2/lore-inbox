Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTIQVYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbTIQVYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:24:40 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:51113 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262855AbTIQVYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:24:38 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <Pine.LNX.4.44.0309172304470.8512-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309172304470.8512-100000@deadlock.et.tudelft.nl>
Message-Id: <1063833817.585.220.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Sep 2003 23:23:38 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Patch: Make iBook1 work again
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-17 at 23:10, Daniël Mantione wrote:
> On Wed, 17 Sep 2003, Benjamin Herrenschmidt wrote:
> 
> > Unfortunately, the wallstreet doesn't work neither. I get something strange on the
> > screen. It's somewhat sync'ed but divided in 4 vertical stripes, each one displaying
> > the left side of the display (+/- offseted), along with some fuzziness (clock wrong).
> 
> Actually, is the problem perhaps this:

It looks like this indeed. What is the cause you are thining about ?

> Let's assume we have columns numbered from 0 to 79 i.e.
> 
> 00000000001111111111222222222233333333334444444444555555555566666666667777777777
> 01234567890123456789012345678901234567890123456789012345678901234567890123456789
> 
> Perhaps your display is like this:
> 
> 00000000001111111111000000000011111111110000000000111111111100000000001111111111
> 01234567890123456789012345678901234567890123456789012345678901234567890123456789
>                    **                  **                  **              *****
> 
> Around the areas marked with ** there can be a lot of noise.
> 
> ??
> 
> 
> If this is the case I know the cause.
> 
> Greetings,
> 
> Daniël
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

