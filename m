Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTHUOPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbTHUOPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:15:14 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:4800 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262681AbTHUOPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:15:10 -0400
Date: Thu, 21 Aug 2003 16:14:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jamie Lokier <jamie@shareable.org>, Andries Brouwer <aebr@win.tue.nl>,
       Vojtech Pavlik <vojtech@suse.cz>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821141457.GA24409@ucw.cz>
References: <20030821134854.GA28593@mail.jlokier.co.uk> <Pine.GSO.3.96.1030821155653.2489I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030821155653.2489I-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 04:08:30PM +0200, Maciej W. Rozycki wrote:

>  Disabling the translation in the onboard 8042 solves the problem and I am
> quite surprised there are problems with that.  After all a pass-through
> mode is easier to implement than a cooked one -- it's essentially a no-op.

Yes, but on a notebook, you often don't have a microcontroler in the
keyboard itself, and there is no wire over which the untranslated set2
scancodes would be passed. The i8042 directly scans the keyboard matrix.
Then it's easy to forget about the set3 scancode set ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
