Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWHGQa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWHGQa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWHGQa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:30:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:14200 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932209AbWHGQa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:30:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hQKhcTtW0eYPa5u8syAY+KcbshmRoHtnb+FxLTZL09G5rxSHJDrHxOUfij1MWMh1nfaxfcF5cT33bZnbqeRyaVWmj43OnMUrjEvuiIWmpbUok/xbClftxW5sZY2wiAdY1l0ojC4OCb16rfqWNWw7hizH1ej1ovLDFttdN/rWLW4=
Message-ID: <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
Date: Mon, 7 Aug 2006 19:30:55 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807140721.GH4032@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492543835-git-send-email-multinymous@gmail.com>
	 <20060807140721.GH4032@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> > +     int total, ret;
> > +     for (total=READ_TIMEOUT_MSECS; total>0; total-=RETRY_MSECS) {
>
> Could we go from 0 to timeout, not the other way around?

Sure.
(That's actually vanilla hdapsd code, moved around...)


> This actually changes userland interface... but that is probably okay.

Those two sysfs attributes were bogus. If anything used them (which I
very much doubt), it's a good thing we broke it.

OK on the rest.

  Shem
