Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWHHMWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWHHMWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWHHMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:22:39 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:28020 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932567AbWHHMWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:22:38 -0400
Date: Tue, 8 Aug 2006 15:22:34 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Shem Multinymous <multinymous@gmail.com>, Pavel Machek <pavel@suse.cz>,
       Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060808122234.GD5497@rhun.haifa.ibm.com>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492543835-git-send-email-multinymous@gmail.com> <20060807140721.GH4032@ucw.cz> <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com> <20060807182047.GC26224@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060807182047.GC26224@atjola.homenet>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 08:20:47PM +0200, Björn Steinbrink wrote:
> On 2006.08.07 19:30:55 +0300, Shem Multinymous wrote:
> > Hi Pavel,
> > 
> > On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> > >> +     int total, ret;
> > >> +     for (total=READ_TIMEOUT_MSECS; total>0; total-=RETRY_MSECS) {
> > >
> > >Could we go from 0 to timeout, not the other way around?
> > 
> > Sure.
> > (That's actually vanilla hdapsd code, moved around...)
> 
> Maybe you could convert that to sth. like this along the way?
> 
> int ret;
> unsigned long timeout = jiffies + msec_to_jiffies(READ_TIMEOUT_MSECS);
> for (;;) {
> 	ret = thinkpad_ec_lock();
> 	if (ret)
> 		return ret;

Just in case someone was going to cut and paste, this will return with
the ec_lock taken.

Cheers,
Muli
