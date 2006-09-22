Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWIVN3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWIVN3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWIVN3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:29:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:11996 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932428AbWIVN3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aukW4QhlFjnHztzjbZ7Evx1sCLsATHyRf/j8rOz7T8fV4GQ3JWDRvwmpxpX326lVLEd3V5yqQZYDM1D3yIwZqB5RPoe+isjxwnnU2GkhrNjdkkGAYcWsEwOXUrJy7nU4q5muy6kr2V5iELrsA9DI+nSMTIFhLDmBB1ykkwWe1Fk=
Message-ID: <bd0cb7950609220629i191683bq7b21fca3e04fafb1@mail.gmail.com>
Date: Fri, 22 Sep 2006 09:29:46 -0400
From: "Tom St Denis" <tomstdenis@gmail.com>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: sky2 eth device with Gigabyte 965P-S3 motherboard
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4513D362.8030804@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bd0cb7950609200635qae3e0c6p3f7d776d33b50542@mail.gmail.com>
	 <4513D362.8030804@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Daniel Drake <dsd@gentoo.org> wrote:
> This device was not listed in the 2.6.17 sky2 driver and is not included
> in the 2.6.18 version either. Either you modified your 2.6.17 kernel or
> your distro did.

It is detected with the latest 2.6.17 kernel automatically [during
udev] and works fine.

> You can simply add the device ID to the list in 2.6.18. Patches to do
> this are already on their way to mainline for 2.6.19.

This won't be fixed as part of 2.6.18.x?  Looking at the source for
the latest gentoo-sources in the 2.6.17 stream I don't see ID 4364 in
the source for sky2.c [sky2_id_table[]].  So why is it detected and
working there but not in 2.6.18?

I'll try adding the device to the table and see what happens.

Hint:  ICH8 was "fixed" between 2.6.17 and 2.6.18 and all of a sudden
my gige stops working which is attached off the ICH8.

Tom
