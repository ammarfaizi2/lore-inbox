Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWHGQO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWHGQO3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWHGQO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:14:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:48212 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932198AbWHGQO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:14:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pe1N3igYc0rm9mcHXbuQSjqhGRSwdEsz9COuvy9U9A/fO4QS39AXqwH7gqh2KU4ji1+gzUpjslN4rmUebZo90nQkiNTIJw4JYorHLYX4TpLro4CXFUOP6JzQyX5hCyN5EVdMBnVstKM+80hYomMmkBJ8pzvbTsxb4U6SnJJ/ZGM=
Message-ID: <41840b750608070914h5817b8b0m977141be455067c4@mail.gmail.com>
Date: Mon, 7 Aug 2006 19:14:27 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807140222.GG4032@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <1154849246822-git-send-email-multinymous@gmail.com>
	 <20060807140222.GG4032@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> > +     /* Parse position data: */
> > +     pos_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1) * (hdaps_invert?-1:1);
> > +     pos_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1) * (hdaps_invert?-1:1);
> > +
> > +     /* Parse so-called "variance" data: */
> > +     var_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS2) * (hdaps_invert?-1:1);
> > +     var_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS2) * (hdaps_invert?-1:1);
>
> Perhaps hdaps_invert should already have 1/-1 values.

It's also used as a module parameter, which is 0/1 in mainline. I
don't think this is worth extra code.


> >  {
> > -     int ret = thinkpad_ec_lock();
> > +     int ret;
> > +     ret = thinkpad_ec_lock();
>
> I actually liked the previous version more, and this change does not
> really belong here.

(That's a diff artifact, it's a totally different function...)
Changed to the version you like.

  Shem
