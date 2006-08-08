Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWHHN3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWHHN3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWHHN3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:29:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:55192 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932584AbWHHN3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:29:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nYP6YaxJLE2oZV0Z6GYTiVOUP4E9nRtsnT+dl6OPhlepcCR8vCZnOUYcpVXRDnylUaQouS6IEKhnj+v4lsejrJv60BtqDJXgtyQXMD/5szydmcNiO33yzq/VdxS+jDGUXyRSVNglT2yW0vBk9nKhfXu95H/zWAFZiThn1rogvb4=
Message-ID: <41840b750608080628s1d785de3xa7a40c6eb5d42833@mail.gmail.com>
Date: Tue, 8 Aug 2006 16:28:59 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 10/12] hdaps: Power off accelerometer on suspend and unload
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060808124547.GH4540@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492972486-git-send-email-multinymous@gmail.com>
	 <20060808124547.GH4540@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/8/06, Pavel Machek <pavel@suse.cz> wrote:
> > +     if (hdaps_set_power(0))
> > +             printk(KERN_WARNING "hdaps: cannot power off\n");
> > +     if (hdaps_set_ec_config(0, 1))
> > +             printk(KERN_WARNING "hdaps: cannot stop EC sampling\n");
> > +}
>
> Maybe propagate error value?

I could do that, but both callers will still discard it -- the power
draw change is negligible, and it's not interesting enough to abort
either suspend or module unload.

OK on all remaining comments.

I'll wait a bit for additional comments and then post the revised series.

  Shem
