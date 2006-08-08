Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWHHNR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWHHNR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWHHNR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:17:29 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:18270 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932491AbWHHNR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:17:28 -0400
Date: Tue, 8 Aug 2006 16:17:24 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Shem Multinymous <multinymous@gmail.com>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060808131724.GE5497@rhun.haifa.ibm.com>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492543835-git-send-email-multinymous@gmail.com> <20060807140721.GH4032@ucw.cz> <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com> <20060807182047.GC26224@atjola.homenet> <20060808122234.GD5497@rhun.haifa.ibm.com> <20060808125652.GA5284@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808125652.GA5284@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 12:56:52PM +0000, Pavel Machek wrote:

> > > 	ret = thinkpad_ec_lock();
> > > 	if (ret)
> > > 		return ret;
> > 
> > Just in case someone was going to cut and paste, this will return with
> > the ec_lock taken.
> 
> Well, taking lock failed (hence error return) so I think code is
> correct.

Ugh, I missed that - it's called _lock(), but it's actually
down_interruptible(). Why not just get rid of the wrapper and call
down_interruptible() directly? That makes it obvious what's going on.

Cheers,
Muil
