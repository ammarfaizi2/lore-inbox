Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276197AbRJCNL2>; Wed, 3 Oct 2001 09:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276201AbRJCNLR>; Wed, 3 Oct 2001 09:11:17 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:51207 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S276197AbRJCNLK>; Wed, 3 Oct 2001 09:11:10 -0400
Date: Wed, 3 Oct 2001 15:11:28 +0200
From: Jan Hudec <bulb@ucw.cz>
To: "M.Gopi Krishna" <mgopi@csa.iisc.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait_event() :(
Message-ID: <20011003151128.A20185@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	"M.Gopi Krishna" <mgopi@csa.iisc.ernet.in>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011003110629.A29671@artax.karlin.mff.cuni.cz> <Pine.LNX.4.21.0110031437570.21820-100000@opal.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110031437570.21820-100000@opal.csa.iisc.ernet.in>; from mgopi@csa.iisc.ernet.in on Wed, Oct 03, 2001 at 02:39:09PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It inserts itself in a wait queue. The schedule returns when wakeup is called
> > on the wait queue.

You may have processes waiting for different events on a single wait queue.
Calling wakeup wakes them up all. Eg. you may have 1 queue per object and
all events wake it up.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
