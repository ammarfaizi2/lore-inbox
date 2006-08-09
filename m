Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWHIJCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWHIJCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbWHIJCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:02:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37859 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030471AbWHIJCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:02:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n8I8zc3AUT3vn4+WtkS2/JFXQ+01n3znCaNKiiPB3TKQN0jradN0TK78wkqauMiIdUqXPMd378lFXNL93rzWLrKAk/uImhtHiHYDxmNLGhlUA6YHuP9cTuGj8bY9m/DJHJW0uZLMP1Mk7E6kK4c4w70eF1TIIF0A2lY1W7pQQG0=
Message-ID: <41840b750608090202k4dcac1b3h38c1f98d398af479@mail.gmail.com>
Date: Wed, 9 Aug 2006 12:02:39 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Pavel Machek" <pavel@suse.cz>,
       "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060809034434.GA4665@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
	 <20060808122234.GD5497@rhun.haifa.ibm.com>
	 <20060808125652.GA5284@ucw.cz>
	 <20060808131724.GE5497@rhun.haifa.ibm.com>
	 <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com>
	 <20060808134337.GF5497@rhun.haifa.ibm.com>
	 <41840b750608080753v27a0ce16xf4da0ad177b08657@mail.gmail.com>
	 <1155050380.5729.89.camel@localhost.localdomain>
	 <41840b750608080833p6e7cfffx890f9c4732b93e73@mail.gmail.com>
	 <20060809034434.GA4665@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> > >If the concern is just the naming then change it to end _trylock
> >
> > We already have a thinkpad_ec_trylock() for the non-blocking
> > variant.
>
> thinkpad_ec_down_interruptible()?

Just ran out, of that sir,

If we'll need to lock away ACPI (just matter of time, my guess), we'll
stumble upon the non-interruptible down()s deep inside in the ACPI
code. So we can't guarantee and shouldn't promise it's really
interruptible.

It's not that strange that a function might fail even if it's named
"do_something()", you know. It's down() that forms an exception - it's
so simple we know it can't fail.

  Shem
