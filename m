Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161252AbWJ3RuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWJ3RuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWJ3RuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:50:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:56552 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161311AbWJ3Rt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:49:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SsDjwt2JfO+j4WgXc2OBYixHwmj79x8ojKQqMro7Dzh6c6kQPxE1BBcifQoRBE3FkMEQHUP+Fq2MMcLPCHxACPXqzBXwpKeNryNbKGniBha0KL9W6Myz0mwfasJApu585VkiywJu7jQmpnyOoPD0wC326GyIcPVOP8WaSQd0+jI=
Message-ID: <f46018bb0610300949i59476730q989c51d1c90e2633@mail.gmail.com>
Date: Mon, 30 Oct 2006 12:49:57 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: kune@deine-taler.de
Subject: Re: [PATCH] wireless-2.6 zd1211rw check against regulatory domain rather than hardcoded value of 11
Cc: "Daniel Drake" <dsd@gentoo.org>, zd1211-devs@lists.sourceforge.net,
       linville@tuxdriver.com, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, holdenk@xandros.com,
       "Johannes Berg" <johannes@sipsolutions.net>
In-Reply-To: <1162197749.2854.5.camel@ux156>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f46018bb0610231121s4fb48f88l28a6e7d4f31d40bb@mail.gmail.com>
	 <453D48E5.8040100@gentoo.org>
	 <f46018bb0610240709y203d8cdbw95cdf66db23aa1ce@mail.gmail.com>
	 <453E2C9A.7010604@gentoo.org> <4544CBC8.5090305@deine-taler.de>
	 <1162197749.2854.5.camel@ux156>
X-Google-Sender-Auth: d66ce4e593d28e3f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulrich,

I'm fairly certain the patch is safe, even for non-US regulatory domains.

Looking at the zd1211rw code the highest channel in the geo object
would appear to be set in zd_geo_init as determined by
zd_channel_range which just does a simple look up in channel_ranges[],
so if this code behaves correctly [and there is no indication it does
not], then setting the upper channel to be that in the geo object
would appear to be safe for any of the supported regulatory domains.

Cheers,

Holden :-)

On 10/30/06, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> > I'm not so sure about this. This patching might be US-specific and we
> > cannot simply apply the setting for top channel of another domain
> > instead of channel 11. One option would be to set the value only under
> > the US regulatory domain.
>
> ??
> What the patch does is replace the top channel which is hardcoded to 11
> by the top channel given by the current regulatory domain. How can that
> be wrong? Except that you may want to init the regulatory domain from
> the EEPROM but I'm not sure how the ieee80211 code works wrt. that.
>
> johannes
>


-- 
Cell: 613-276-1645
