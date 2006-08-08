Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWHHNfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWHHNfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWHHNfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:35:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:64422 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964878AbWHHNfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:35:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HKWRxSXy6KRgMfLBZEfGA6w9WzB3LBUuI4UFTCmti999r45fOGqi+eEO7g2xB73G+H3qXR+d01My5eqB8d3fjKOOuQiJUCJjfOaCNAWaIuPWxXQxOaIgI99Pip/BBlRMTlilnDuM1Rnd4we+TiqNnZtK/OAku68+uSICo8LJqRU=
Message-ID: <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com>
Date: Tue, 8 Aug 2006 16:35:23 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Cc: "Pavel Machek" <pavel@suse.cz>,
       "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060808131724.GE5497@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492543835-git-send-email-multinymous@gmail.com>
	 <20060807140721.GH4032@ucw.cz>
	 <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
	 <20060807182047.GC26224@atjola.homenet>
	 <20060808122234.GD5497@rhun.haifa.ibm.com>
	 <20060808125652.GA5284@ucw.cz>
	 <20060808131724.GE5497@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muli,

On 8/8/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> > > >   ret = thinkpad_ec_lock();
> > > >   if (ret)
> > > >           return ret;

> Ugh, I missed that - it's called _lock(), but it's actually
> down_interruptible().

Why is that confusing?

> Why not just get rid of the wrapper and call
> down_interruptible() directly? That makes it obvious what's going on.

We may end up needing to lock away other subsystems (ACPI?) that
touch the same ports. Apparently not an issue right now, but could
change with new firmware. (http://lkml.org/lkml/2006/8/7/147)

  Shem
