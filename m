Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTIQVLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbTIQVLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:11:03 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:8883 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S262726AbTIQVLA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:11:00 -0400
Date: Wed, 17 Sep 2003 23:10:57 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: Patch: Make iBook1 work again
In-Reply-To: <1063829278.600.184.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309172304470.8512-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Sep 2003, Benjamin Herrenschmidt wrote:

> Unfortunately, the wallstreet doesn't work neither. I get something strange on the
> screen. It's somewhat sync'ed but divided in 4 vertical stripes, each one displaying
> the left side of the display (+/- offseted), along with some fuzziness (clock wrong).

Actually, is the problem perhaps this:

Let's assume we have columns numbered from 0 to 79 i.e.

00000000001111111111222222222233333333334444444444555555555566666666667777777777
01234567890123456789012345678901234567890123456789012345678901234567890123456789

Perhaps your display is like this:

00000000001111111111000000000011111111110000000000111111111100000000001111111111
01234567890123456789012345678901234567890123456789012345678901234567890123456789
                   **                  **                  **              *****

Around the areas marked with ** there can be a lot of noise.

??


If this is the case I know the cause.

Greetings,

Daniël

